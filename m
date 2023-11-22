Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158A7F46EE
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:51:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mg9-0002Vz-UY; Wed, 22 Nov 2023 07:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1r5mg8-0002Vn-S9
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:50:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1r5mg7-0005B7-5k
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700657399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
 b=LgKniuUK1qMEE26G4bb+UQyvZWVjzjQ+6Ao9XZrVnihGm44Tryt2u1WSXRSRTtBDGWf9Wm
 cFAV6kWmJPbehkpjIdm5joNSQaTNz2jTc4HklDFbvzKCA0eD2Iq2IjgdbghgGkO436hIxU
 zMBptiz0w6oa1Or9pwq6TwU11JR1+M0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Of-5NHaAM6mWBSFzSxPlyQ-1; Wed, 22 Nov 2023 07:49:58 -0500
X-MC-Unique: Of-5NHaAM6mWBSFzSxPlyQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c876d239e6so38371031fa.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 04:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700657397; x=1701262197;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
 b=rkUA/VzhHFaYyiPWSb5CeGldE3VYUUYYsx19c6ZhOBo3iUs9qo0a/KB/SjiTKS9b/+
 xpNNMJ3K3UunEkmSwtgQ1Me/eForrZO4x/cHIogXJl+806TDVeAG0jD7PwUzGwToKS3Z
 7uyVzDufzk1ZhJ87cx3WlFM4y0tGF7upDn6rVnwdZ8y6PX5bNlO+4MN6SsepT09RCZyB
 efqeZgvTOkHPALajxTjFc7dGHfibcFIDE1YmIOqGC353LC4szPAF2CmAPQbpWZ2SJUYF
 p/To6G5JYyQtEivQ6KSiENRVTJv1Xf6Lv5BH2NhNxCsiv19jZXOlX+smwxkZa9seq1ZO
 u/8g==
X-Gm-Message-State: AOJu0YwINzFgj+hlKulklBgUCbEi1jwwsQprMV+9vKS8zTIv2zl05HuT
 SCy33pExx7AQTRcDDlWWCVbR8cRsjJ0BYNnEGn2g5ORnenpdozWabRO7AUoH/t/ot3KUWQfE8bb
 /QN0tY9eT52zPciY=
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id
 s2-20020a2e98c2000000b002c5213224f6mr1644880ljj.12.1700657397034; 
 Wed, 22 Nov 2023 04:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjsqJ2SuGehTUxt/XdTWeav04muk69t7/+AFuoFYCMhKZg56Vp4jkvGQpcnN18Ay8LgHfnHQ==
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id
 s2-20020a2e98c2000000b002c5213224f6mr1644863ljj.12.1700657396682; 
 Wed, 22 Nov 2023 04:49:56 -0800 (PST)
Received: from localhost ([90.167.94.248]) by smtp.gmail.com with ESMTPSA id
 bg36-20020a05600c3ca400b0040775501256sm2103506wmb.16.2023.11.22.04.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 04:49:56 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, Simon Ser <contact@emersion.fr>
Cc: qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>, Matt Roper
 <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>,
 banackm@vmware.com, Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
 spice-devel@lists.freedesktop.org, Gurchetan Singh
 <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>, David
 Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mombasawalam@vmware.com, Daniel Vetter
 <daniel@ffwll.ch>, ppaalanen@gmail.com, VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Date: Wed, 22 Nov 2023 13:49:55 +0100
Message-ID: <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=fmartine@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

Albert Esteve <aesteve@redhat.com> writes:

Hello,

[...]

>
>> > Mutter patch:
>> > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>>
>> Seems like this link is same as IGT? Copy-pasta fail maybe?
>>
>>
> Ah yes, my bad, this is the correct link:
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

The mutter chages are already in good shape and the MR has even be
approved by a mutter developer. Any objections to merge the series ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


