Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B67F722B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:57:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Trl-00081g-NQ; Fri, 24 Nov 2023 05:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1r6Tri-0007om-6w
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1r6Trg-0000FB-EE
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700823410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
 b=KzBRBjPn75EPFXQmrdZAcao9Prerc8uwlwuXbMKBPGCjHqAFwrB1JkZrJAeZg1yph9BnaJ
 08h9tZxDQmauS9+CeW2UyVdmgWa7XjIN985aA29Idh9PXT6ylSUfRwMAJk+a8i7goanMbW
 6TGGjd8PE0WfJsK2AY05KYadrLIntOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-pHAcy0QcMJShIpZ26SnluA-1; Fri, 24 Nov 2023 05:56:49 -0500
X-MC-Unique: pHAcy0QcMJShIpZ26SnluA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so11005935e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700823408; x=1701428208;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
 b=pxpHavyPb+PfivhQnPdMV3ryHzW6rxkt7/E7CRbJKGfa+ctR67dU70l+kk/psvaxpr
 eo3hntAeO1wgALrbIyGi5p1QtXDsY/kUBvZ+9j+LinvpaCJozzdRrmNf3oGZ46noDYOP
 aDVVu3UbXtb539VfjoDIPMtIJ4YL/ZC93TOP6Dyixa0gkAJyA+TC4mb59RPglS1wNR/9
 dvKICG3jZewBIXJYbGUVibfIKudzsQhmeuwFbuJ7VyFg8aUwKOmarqSSIiefHgfI4LJ/
 7QEXPwQ+xxgIv47HlIc+65zHf/R8QDQfHk7zUOnLykbaw5z0ZpmE+zVenonRtZf+MTTl
 afCA==
X-Gm-Message-State: AOJu0Yw8Y/aVaY37phqG4zCULztrTA0RBWKQR7XIYqY+vaXKUi5oCB4K
 MQOFkbuAbukaTNx5inhnX8BzAgxyWvtce12Jf7ykJ7sz/XxPavvMBo6xbohIHrUNkOSIrl7PGb4
 mWEjMEK5/3m++Dgs=
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id
 r21-20020adfb1d5000000b0032daa11221dmr1609057wra.27.1700823408225; 
 Fri, 24 Nov 2023 02:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8B1Z5Xh4NJM4v+jFXHb5dS3jyH1zOINaNv+9ttW9vntLWVjkhOG5VMvKimijwhgUpy+ZIgA==
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id
 r21-20020adfb1d5000000b0032daa11221dmr1609038wra.27.1700823407919; 
 Fri, 24 Nov 2023 02:56:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b00327de0173f6sm4052394wrr.115.2023.11.24.02.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:56:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Simon Ser <contact@emersion.fr>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 zackr@vmware.com, linux-doc@vger.kernel.org,
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
In-Reply-To: <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
 <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
 <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
Date: Fri, 24 Nov 2023 11:56:46 +0100
Message-ID: <87leanctch.fsf@minerva.mail-host-address-is-not-set>
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

Simon Ser <contact@emersion.fr> writes:

Hello Simon,

> On Wednesday, November 22nd, 2023 at 13:49, Javier Martinez Canillas <javierm@redhat.com> wrote:
>
>> Any objections to merge the series ?
>
> No objections from me :)
>

Perfect, I'll merge this series then to unblock the mutter MR. Thanks again!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


