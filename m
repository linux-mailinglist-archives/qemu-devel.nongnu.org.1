Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B326C7E3654
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:07:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0H6q-0008CX-JB; Tue, 07 Nov 2023 03:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0H6o-00089M-LH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0H6n-0003IS-9W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699344408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX0/IlyIdPBsXcRMir1ktQb0QUJkus32Sx+zPjHn/KM=;
 b=E+kimHjUZ78eO7E+bJ0Li/zKBM97J+BBm9r7ZyQWfsKZ2oC9NpuxUyAPlH/R9w/l5GwVc4
 /YfqoX4dmN5HArOZ77Vim3wsnMQN6yVgd7zCPIgx1hSnGW8iWLqzhmxTznQyf3nYx19Lsi
 MypXQ447smfc/KCUTLduYJycA8/uKws=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vvnBnz1OOsOk1Mo5fqJXHw-1; Tue, 07 Nov 2023 03:06:28 -0500
X-MC-Unique: vvnBnz1OOsOk1Mo5fqJXHw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9be601277c2so387529366b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699344387; x=1699949187;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rX0/IlyIdPBsXcRMir1ktQb0QUJkus32Sx+zPjHn/KM=;
 b=RKvd79DM5ekea4TZEtV+rFaDRetLsKpIImhClmOp5klgXg8TzWS/Fh4kwCgMoJCfGj
 NZ7tknfOTPx879g6VSe8Wlk4mSlHYEdtTVpPwOgOTBPT9tVojxG+Z75erN//7CUTV3yk
 FcIfnQrQlzIHXwbzlNXSB7J0c8NVgoxETUmOXMHgQOXr39nPtJDwEZ9VV36YLaVAgRq9
 Eu56ZzDc2P3JyKnYSNgAo1irqc1EyisOAiY2lZpzaiatebRjX4uEOfb1BGQyhInxraj5
 3fTc5FtkeywfSSqPmzL3St6kdTdu895y93oYhdnKjlJpQQ5FgKchW4X/VV0FSDvMIgwq
 6Q4Q==
X-Gm-Message-State: AOJu0YznDeVjVO+gz+c5rAUF/9oWiIL0mUfYSdIXHeqQ9wCwgQYwrftM
 7ITDs6EW6AB9phajWgkrfcdBeFzIW0oWMHG8ejjIPxDW/4rTNOIHCr0n/oYia2WDDkYdn0Qv+Fk
 K2lTDSfAhlDaYRq0=
X-Received: by 2002:a17:907:a0a:b0:9c3:e158:316a with SMTP id
 bb10-20020a1709070a0a00b009c3e158316amr15683401ejc.68.1699344387658; 
 Tue, 07 Nov 2023 00:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCWSY78VF1bjOKSJ2kncYdbJNeK2RqxWJDMT0zAv19DTYz8s4o9MQ4U0HfZBiZiIjGPckq4A==
X-Received: by 2002:a17:907:a0a:b0:9c3:e158:316a with SMTP id
 bb10-20020a1709070a0a00b009c3e158316amr15683386ejc.68.1699344387350; 
 Tue, 07 Nov 2023 00:06:27 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 az25-20020a05600c601900b004095874f6d3sm15122911wmb.28.2023.11.07.00.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 00:06:26 -0800 (PST)
Date: Tue, 7 Nov 2023 03:06:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 1/6] virtio: split into vhost-user-base and
 vhost-user-device
Message-ID: <20231107030523-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231106191515.2801863-2-alex.bennee@linaro.org>
 <20231107023330-mutt-send-email-mst@kernel.org>
 <87jzqu6ldn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzqu6ldn.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 07, 2023 at 08:03:16AM +0000, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Nov 06, 2023 at 07:15:10PM +0000, Alex Bennée wrote:
> >> Lets keep a cleaner split between the base class and the derived
> >> vhost-user-device which we can use for generic vhost-user stubs. This
> >> includes an update to introduce the vq_size property so the number of
> >> entries in a virtq can be defined.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
> >
> > Please do not put Message-Id tags in patches you post.
> > These are used to map patches to email - this patch was
> > In-Reply-To: <20231106191515.2801863-2-alex.bennee@linaro.org>
> 
> It was the last time it was posted. I just strip off the old ones when I
> apply to my tree before preparing a pull request.

Let's make vanilla git am work please.  Pls strip them when you post.

-- 
MST


