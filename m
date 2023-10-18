Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF07CE285
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:18:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Fk-0001i3-4U; Wed, 18 Oct 2023 12:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qt9FV-0001Hy-Do
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qt9FG-0003MB-PP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697645880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hsQ1estGFBdj4PmeyKbQlkuV1OkbFHfrXE/Gj4zDL4=;
 b=dwazwHbGWKNoKL6Tud+3MGLFBWgvoOKG8xD/4NZVGMxmBg1Cegg8G3kt/YiQ5KwaS+KkrD
 8BLUAw5u1rYtQ+6+C/H+DT3AWitygkKNDLPqY640PNoSkAzs72AWLwIVHIEHB28plcKZJg
 rhwGun7GSMGS4zBxx9oPZTRS12r5K50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Z1iRwi1qPEGCC2Icgabrdg-1; Wed, 18 Oct 2023 12:17:48 -0400
X-MC-Unique: Z1iRwi1qPEGCC2Icgabrdg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32cbe54ee03so4147674f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645867; x=1698250667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8hsQ1estGFBdj4PmeyKbQlkuV1OkbFHfrXE/Gj4zDL4=;
 b=Jv9pAxDKv+3W4zmFImiplSuIXRXxnGKOQmJ1t6Q16X25RmUEf4bWma9bcV5mlxCg5h
 hSTVrlcoZaYGZot0QuNsVy6Hrvpxf+up6fC5iGZaPcuPW0khU3kJTqYDtTPqdwunw6t+
 4CjlsenQYNoYoSJAc65189QiMIf1UfsNRuur8IlIqB7VCiJpETCIXKnbGbO7FfvBgfmM
 xl8F3yxSkskKrel+AnWjGL0/Mc12zyphknA96bffBReKTcSBejpH/rA2vj9h6AZNfCJY
 WpTWcXnQtWA3+Rgm41e13tuMfK9Ya/wXTIPWo+U79fAlsOdUJcISavfonUmt3iYuRR77
 h6fg==
X-Gm-Message-State: AOJu0YzETPVzvZbLUmbxE4CkJjzU6NDz8O/HZvPf2y6wFxOEPgY3b9PP
 s7w3IU6CeOW5ckJR+V1gC/6abdx0WhFyNcEkriNdAAPYHQI0q2xCcAxX0jfAu8hQCt1zPBSkPpk
 H3Mxu/dSpbWOihnTUP7Vnow0=
X-Received: by 2002:a5d:61cc:0:b0:32d:a98c:aa24 with SMTP id
 q12-20020a5d61cc000000b0032da98caa24mr4129867wrv.3.1697645867341; 
 Wed, 18 Oct 2023 09:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUsJjUwto61Uc7QoYA/ENWI7IJaxrp6CcXvBT84F42f8ZRVkfaHysJPGOHp93RGL5RHBmCiw==
X-Received: by 2002:a5d:61cc:0:b0:32d:a98c:aa24 with SMTP id
 q12-20020a5d61cc000000b0032da98caa24mr4129849wrv.3.1697645867038; 
 Wed, 18 Oct 2023 09:17:47 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d444c000000b0032da022855fsm2423659wrr.111.2023.10.18.09.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 09:17:46 -0700 (PDT)
Message-ID: <cc513d48-bf05-557c-2e93-fb26480cd83c@redhat.com>
Date: Wed, 18 Oct 2023 18:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/8] vhost-user.rst: Clarify enabling/disabling vrings
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione
 <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>
References: <20231018081336-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231018081336-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.10.23 14:14, Michael S. Tsirkin wrote:
> On Wed, Oct 04, 2023 at 02:58:59PM +0200, Hanna Czenczek wrote:
>> Currently, the vhost-user documentation says that rings are to be
>> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
>> negotiated.  However, by the time of feature negotiation, all rings have
>> already been initialized, so it is not entirely clear what this means.
>>
>> At least the vhost-user-backend Rust crate's implementation interpreted
>> it to mean that whenever this feature is negotiated, all rings are to
>> put into a disabled state, which means that every SET_FEATURES call
>> would disable all rings, effectively halting the device.  This is
>> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
>> this way, which happens during migration.  Doing so should not halt the
>> device.
>>
>> Other implementations have interpreted this to mean that the device is
>> to be initialized with all rings disabled, and a subsequent SET_FEATURES
>> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
>> them.  Here, SET_FEATURES will never disable any ring.
>>
>> This interpretation does not suffer the problem of unintentionally
>> halting the device whenever features are set or cleared, so it seems
>> better and more reasonable.
>>
>> We can clarify this in the documentation by making it explicit that the
>> enabled/disabled state is tracked even while the vring is stopped.
>> Every vring is initialized in a disabled state, and SET_FEATURES without
>> VHOST_USER_F_PROTOCOL_FEATURES simply becomes one way to enable all
>> vrings.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>
> OK so I am expecting v5. My advice is to move patch 1 to end of patchset
> so we can defer it if we want to.

Already sent – I’ve just dropped patch 1, since it doesn’t add anything 
to the objective of the patch series itself:

https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg04727.html

Hanna


