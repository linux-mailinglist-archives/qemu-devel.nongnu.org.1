Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6E830BA0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:01:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9Hl-000520-RW; Wed, 17 Jan 2024 12:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ9HV-0004ul-L4
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ9HU-0006AG-0Y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705510846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zBlQeVPWT2/6ZguHrChwUXvimwrH5kI3/tiPecFBc4=;
 b=PNxS1Qg8jpl6ASpYizUSAgS6sRGJhZehwLNE50b5Dq+nB4bXswKeS+se5XbAAN6IKygiML
 OYdIEp4ICG6PpSfXHdK7WGcw1PIjufVEGOKst7a/oulpTbp5s9W2wVha6NVON6pLaVd2vs
 uDeHOaVESPYOg2fT6H/Ez2oaE/PWrUI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-njRFUTCOMFO1owzVTiefOw-1; Wed, 17 Jan 2024 12:00:45 -0500
X-MC-Unique: njRFUTCOMFO1owzVTiefOw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68058b0112cso225441166d6.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705510845; x=1706115645;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zBlQeVPWT2/6ZguHrChwUXvimwrH5kI3/tiPecFBc4=;
 b=IKzIszahy5plgzOlx/dxQk58ofEEQCMyjDgAOiRaxrGkjOCDsvJm2DK4PywN7rGBmt
 Zy9uHiFC85wZZ9aEE2jmvrJKlMsTeBQbINSLGFQmWhstOixR13WuI6ALAio2wP+OksFJ
 8g8p3mNiF09CBSDwQ6pLYwiryD8t0h7FcXGx+aWf7x+MDt5DNAZWuWdrTXy6fxmmiyOf
 c+qk1OmOKyRdqiX81qzT64aiJA0IPH1r9lynzbUKf8gHHSywc6OGe8icmMPsQ06ECxrl
 OEnZywd8oddIxO9rJYeY4ZZQcLEGNCzMsb+vYCJQDEH7575Gic5L9vcWsyICcXxmIME7
 6TGg==
X-Gm-Message-State: AOJu0Yz68OFcRugFy4lHm7J6aJgQ38aFFAE6TsB9Xu/3/P/ORivyr4bX
 ryjnS3YimPv33CQM7JK9Uk9v1jY4YPCsfK8nD5yY+nJtGdowoCaqJ713jHpdBLbWhanORnUc7Ux
 y1TWlex91QbUxJqWiGFXpogo=
X-Received: by 2002:a05:6214:21eb:b0:680:fa99:9edf with SMTP id
 p11-20020a05621421eb00b00680fa999edfmr11252123qvj.68.1705510844511; 
 Wed, 17 Jan 2024 09:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXluelhU2SpgmpCwTyu8mRMw534WtYy4L35xMKPltZutfOyAvvQIxEpxinpG9PWMriP2N4CA==
X-Received: by 2002:a05:6214:21eb:b0:680:fa99:9edf with SMTP id
 p11-20020a05621421eb00b00680fa999edfmr11252103qvj.68.1705510844040; 
 Wed, 17 Jan 2024 09:00:44 -0800 (PST)
Received: from rh (p200300c93f0273004f0fe90936098834.dip0.t-ipconnect.de.
 [2003:c9:3f02:7300:4f0f:e909:3609:8834])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a0cf705000000b006818033cceasm464358qvn.38.2024.01.17.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:00:43 -0800 (PST)
Date: Wed, 17 Jan 2024 18:00:39 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: qemu-devel@nongnu.org, peterx@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-gpu: fix scanout migration post-load
In-Reply-To: <CAJ+F1CKx9orvOMXV-e4S2gZCsFvoOOdv4s2Vu5V7ONnBeJkD0w@mail.gmail.com>
Message-ID: <05a74a9f-255e-b7cf-d80f-a08247b3faeb@redhat.com>
References: <20240115154830.498304-1-marcandre.lureau@redhat.com>
 <20240115154830.498304-3-marcandre.lureau@redhat.com>
 <a67b8127-6445-a29b-ffc4-6c5409e93bbd@redhat.com>
 <CAJ+F1CKx9orvOMXV-e4S2gZCsFvoOOdv4s2Vu5V7ONnBeJkD0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463795790-658638398-1705510843=:15782"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-658638398-1705510843=:15782
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 17 Jan 2024, Marc-André Lureau wrote:
> On Tue, Jan 16, 2024 at 3:17 PM Sebastian Ott <sebott@redhat.com> wrote:
>> On Mon, 15 Jan 2024, marcandre.lureau@redhat.com wrote:
>>> +            scanout->ds = qemu_create_displaysurface_pixman(res->image);
>>> +            if (!scanout->ds) {
>>> +                return -EINVAL;
>>> +            }
>>
>> "qemu_create_displaysurface_pixman() never returns NULL." ;-)
>
> Right, I'll update the first patch.
>
> Other comments about this patch?

Nope, looks good to me.

Reviewed-by: Sebastian Ott <sebott@redhat.com>
---1463795790-658638398-1705510843=:15782--


