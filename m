Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD157D61B9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXUw-0007H9-LS; Wed, 25 Oct 2023 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1qvXUt-0007GC-B3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1qvXUs-0003jR-0B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698215764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QCkYDGehxxNqzt09gBv9p4n2vFS1oLTgsSq6IkVxVA=;
 b=dsYwNf6M7WcSA53ZGzkRMeh4A0kzl9ETfZzNY2Vg52/aFz49wuJ5l0SDK6NaklQ8xcsSvV
 5hMEuhwQa/MKTpbdh+3c5UMf02PuxHtu+QqtZLAhBjaujOL3d/qFW24hGi/gv4B+ln+NXe
 kA7PCfr+thDnqxN3Vf/9lAxtWVzgeHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-5yxWO1_2M8aaePU_lQJGig-1; Wed, 25 Oct 2023 02:36:02 -0400
X-MC-Unique: 5yxWO1_2M8aaePU_lQJGig-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso2348755f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698215761; x=1698820561;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QCkYDGehxxNqzt09gBv9p4n2vFS1oLTgsSq6IkVxVA=;
 b=njZBnXsRjem70RVEpWjLLqsA1ttGm6mwjY27Tqg7RCJl3jPnySuNzt4Ez0WfqaSaAD
 dlMow1D7gB5p4b2jb5TDoxerq4KFZz+s05YuM9YKsndJyfoP3/sR8NORY4lK+pMcANQT
 vuWyMMxDROJXmty+n/KaZV6jwN9vOFR+nqTS8CNu4LuFwNcFY7op+gm1Dn2Rr5HekUbp
 JVZsfAdsUBmiylZSGWqfZZJ9Rxh7EFJAyAJTVh6gbxefiStfV1qycZnb9R6oA22/TMD8
 NWFUlJcQ93qAlWtj7mTddaIbPXTMEPWD/KQGJ1VrwZwCVIgEM4YuCKclJYx6bzeDV142
 +FHQ==
X-Gm-Message-State: AOJu0YwjdlBX0qDa/rf93B1OPFNA65mM7kIFRRJl25M+il8MLrIITZQJ
 YNh6Ktb5ZrIhAv7vUXXG0EHxlsN2OLTTrw4Pyn3sy8IQleUT9tf+QdgGbh3efHCgWhpsK9F24ML
 7KJHOZ2HFfGub4Fc=
X-Received: by 2002:adf:f64a:0:b0:32d:a49c:dfd0 with SMTP id
 x10-20020adff64a000000b0032da49cdfd0mr9244575wrp.64.1698215761749; 
 Tue, 24 Oct 2023 23:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5pjp6+UGcNGf+pR7eCaZquF6TdQK9ic+pGsGfXKq7QOOQ0Jp5pQG5o2Uq/SY5UVuq/3Y74g==
X-Received: by 2002:adf:f64a:0:b0:32d:a49c:dfd0 with SMTP id
 x10-20020adff64a000000b0032da49cdfd0mr9244562wrp.64.1698215761437; 
 Tue, 24 Oct 2023 23:36:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 t14-20020a5d534e000000b0032710f5584fsm11318664wrv.25.2023.10.24.23.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:36:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Michael Banack <banackm@vmware.com>, Albert Esteve <aesteve@redhat.com>,
 qemu-devel@nongnu.org
Cc: linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Gerd Hoffmann
 <kraxel@redhat.com>, mombasawalam@vmware.com, iforbes@vmware.com, Jonathan
 Corbet <corbet@lwn.net>, VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, David Airlie <airlied@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 ppaalanen@gmail.com, spice-devel@lists.freedesktop.org, Gurchetan Singh
 <gurchetansingh@chromium.org>, Matt Roper <matthew.d.roper@intel.com>,
 linux-kernel@vger.kernel.org, krastevm@vmware.com
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot properties
In-Reply-To: <1bbee4ad-79fe-4968-0edc-3eee34ad5972@vmware.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-10-aesteve@redhat.com>
 <87h6mh10zg.fsf@minerva.mail-host-address-is-not-set>
 <1bbee4ad-79fe-4968-0edc-3eee34ad5972@vmware.com>
Date: Wed, 25 Oct 2023 08:36:00 +0200
Message-ID: <87a5s79pkf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=fmartine@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Banack <banackm@vmware.com> writes:

Hello Michael,

> Yes, that patch should be:
>
> Signed-off-by: Michael Banack <banackm@vmware.com>
>

Great, thanks for the confirmation.

> --Michael Banack
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


