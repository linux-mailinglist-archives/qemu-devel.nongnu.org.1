Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F97D41BE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 23:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv2WG-0003e6-H3; Mon, 23 Oct 2023 17:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1qv2WF-0003dw-EQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 17:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fmartine@redhat.com>)
 id 1qv2WD-0002Y1-P4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 17:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698096684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1k2Vg92RJrxv+gYLNepXp/tJyAR04nx8wa9wG6p0is=;
 b=CimN6h1JUMp/gj6nGR8TfO/DAC61/vDmqsrj5voBcsF+0WBdbCWDwGzNR7CovecDcQx7KC
 6XElkjK80WonxCfhuYLwulfbQpU8bb1liWGRRRTeQTXyGonKoeTLjKuJjtajhNUsfgJFbq
 l1s1vlF9GoFeVuEFzNzjA8GiiPv+Pjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-maCHI05XOSGXqitwQfvDGg-1; Mon, 23 Oct 2023 17:29:41 -0400
X-MC-Unique: maCHI05XOSGXqitwQfvDGg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so23325425e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 14:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698096580; x=1698701380;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1k2Vg92RJrxv+gYLNepXp/tJyAR04nx8wa9wG6p0is=;
 b=e9qF0g5x3+SOqjcjFOEp7VRPFR5O8w65K2SQg/wRCwxSbo30PujP8jYlcX/IvhQtvq
 puWPhs+L+5ZlwRc8ylHOjWpMo/EY3mzwmBGdiRE2nyB3pkXl0XhKVsO43CEyep+Q7pY6
 6NEGvhfJEkf1Z6QB3XRSfSKau21/6vvxvZkp67lnYSBvsckE1hCroMM1BoSEkWDZm7ag
 oDxrV6+osGxAzzYGr4esEbrpYa/Xrnu0+329FoTXYGBeJFXWFoaaoZh2ctjZx9goPHrl
 soNb4EJI0bkI+qmlhan4FP7mGApzw/YmmalWCTsBg+geWL9FdtiYjufi++3KxoRszXe6
 a3wQ==
X-Gm-Message-State: AOJu0YwskXJrioC7YqYqJPWdTvVZpXdD4c2cLJVTWZTWb5snQzENoTIM
 miJZZSMXxwqqCtQ9pwMHf4u2zn6HkWAR7Ohiqaa09G1W5NoA9MhJm9DVcQ3GOa1CcHc5f3PGgFP
 n7fuZYGT8ZaXERqY=
X-Received: by 2002:a05:600c:45ca:b0:408:575e:f24f with SMTP id
 s10-20020a05600c45ca00b00408575ef24fmr5647853wmo.28.1698096580653; 
 Mon, 23 Oct 2023 14:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwIqmyWxHtLCEV9sJcM7Mm48Qpb+Y1PSoNkRJSeRh4CaGlNviwDWwltxau6u5GNETKD69b9g==
X-Received: by 2002:a05:600c:45ca:b0:408:575e:f24f with SMTP id
 s10-20020a05600c45ca00b00408575ef24fmr5647840wmo.28.1698096580275; 
 Mon, 23 Oct 2023 14:29:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm14963606wme.9.2023.10.23.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 14:29:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
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
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot properties
In-Reply-To: <20231023074613.41327-10-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-10-aesteve@redhat.com>
Date: Mon, 23 Oct 2023 23:29:39 +0200
Message-ID: <87h6mh10zg.fsf@minerva.mail-host-address-is-not-set>
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

Albert Esteve <aesteve@redhat.com> writes:

> From: Michael Banack <banackm@vmware.com>
>
> To clarify the intent and reasoning behind the hotspot properties
> introduce userspace documentation that goes over cursor handling
> in para-virtualized environments.
>
> The documentation is generic enough to not special case for any
> specific hypervisor and should apply equally to all.
>
> Signed-off-by: Zack Rusin <zackr@vmware.com>

The author is Michael Banack but it's missing a SoB from them.
I don't think there's a need to resend for this, can be added
when applying. But either Michael or Zack should confirm that
is the correct thing to do for this patch.

The doc itself looks great to me and it clarifies a lot about
cursor hotspots.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


