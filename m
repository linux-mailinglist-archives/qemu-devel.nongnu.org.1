Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6A79CB76
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 11:19:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzXB-00064Z-OO; Tue, 12 Sep 2023 05:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfzXA-00064Q-Ja
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:18:12 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfzX6-0004fN-T2
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:18:12 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so9177776e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694510285; x=1695115085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jWzZH5Yf5nddOzMeP2tpzIgv6bvxJnHmJ0hoZ4UydWo=;
 b=KxAh1//UcxmapebOzbDwRTB8eJ/vFZROiu2lxy4Rbk+XIZWCN+GeVTczCYwTdcqMpA
 XVlanMkFdfF8Rt+HJsC/tsrD3rOhQx8R3QTUR3bUK+g2MyMczyxK/HUUVPUqKULytdiP
 papfgxDfeVXqqZlL8EA8Of0U8XKXmhJlIIKQTxDkmJhhXinQG9h4W74McQM03JcX6XKX
 b0Y1LgI8BOSAVd2jxVrvpTtA1ixBjfkEbrHshEbnrD1RrcFtSRLKy6vNiFcGyeesurWf
 rT6rZ7tBKrfMbBUiPAJJAXYOZXv0GJigA9F6bVvahKXg3Jwy5Bh9mo9ZWbJqJ5mAh7FA
 y2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694510285; x=1695115085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWzZH5Yf5nddOzMeP2tpzIgv6bvxJnHmJ0hoZ4UydWo=;
 b=KdWJKqvCHYhs5NQaoeVYPeB9M0Mj1hrm+s/F7Q9rCAz+K9iFaBdv9cvQsPpM5FWRpC
 PMMQdMm+bnasZg08gMMtr+lxbFDBsSnTufoW2hO0V6PWZbHte/O24QBApGi5RqyJ/rrv
 1M9oLXd9+v/ljs0uZEbheqnmr7Yi96pKpp3Wxqwi1n+yN1dGiAgvLDcADTgY7ezlor3G
 9d/VhkhZslZI84kYtOIoOsYd0SA2Crs+IoYn/raR/9Ps7aLt9Ua3pyEprqREECORMAbk
 WBdm479KlySgkQW/yItG8FcWrfZLNQml+c2HoC4Ksb8I6C1LjLbF+WQZRtSj/UUN5fuE
 P7lA==
X-Gm-Message-State: AOJu0YytwNXr0ABlJE9xNDVohOJLD3YOnsOOQ1AFRwz87hkqP+uxorXa
 0MDcyORV+et64K1U7SEL8v3atcBuS0ayYCwh+VR7BA==
X-Google-Smtp-Source: AGHT+IGf9yzIUODLdra32w/g6Q1xsb2WI8Rlq4HVQCEVSy+c2Ct3DtXxQBrxzLi9kp6wLPjS4MrGOlqiuMUCxgkcRCM=
X-Received: by 2002:a05:6512:2205:b0:500:9bbf:da17 with SMTP id
 h5-20020a056512220500b005009bbfda17mr11331058lfu.51.1694510285183; Tue, 12
 Sep 2023 02:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-3-kwolf@redhat.com>
 <CAFEAcA9a15bhpG1Yj-b+3TC=UxDFdGJA4f1VrxnZsgVUR9O1dQ@mail.gmail.com>
 <ZP9DWucJaGt+hcQ1@redhat.com>
In-Reply-To: <ZP9DWucJaGt+hcQ1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 10:17:53 +0100
Message-ID: <CAFEAcA8zxRwivwv2xSQUFUdJgZv80a5_87pqHvcKj0XkRiuDPA@mail.gmail.com>
Subject: Re: [PATCH 02/11] hw/i386/pc: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 11 Sept 2023 at 17:42, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 11.09.2023 um 17:42 hat Peter Maydell geschrieben:
> > On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Instead of manually setting "foo-len" and "foo[i]" properties, build a
> > > QList and use the new qdev_prop_set_array() helper to set the whole
> > > array property with a single call.
> > >
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  hw/i386/pc.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 54838c0c41..0e84e454cb 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -81,6 +81,7 @@
> > >  #include "qapi/error.h"
> > >  #include "qapi/qapi-visit-common.h"
> > >  #include "qapi/qapi-visit-machine.h"
> > > +#include "qapi/qmp/qlist.h"
> > >  #include "qapi/visitor.h"
> > >  #include "hw/core/cpu.h"
> > >  #include "hw/usb.h"
> > > @@ -1508,9 +1509,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> > >          char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
> > >                                                VIRTIO_IOMMU_RESV_MEM_T_MSI);
> > >
> > > -        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
> > > -        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
> > > -                                resv_prop_str, errp);
> > > +        QList *reserved_regions = qlist_new();
> > > +        qlist_append_str(reserved_regions, resv_prop_str);
> > > +        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
> > > +
> >
> > The variable declaration should be at the top of the block;
>
> It is at the top of the block, the only thing before it is another
> variable declaration. Would you prefer to have the empty line removed or
> after the declaration to make this visually clearer?

Sorry, I think I just misread the diff somehow. I guess that having
the blank line after the variable declarations would be more usual,
but it doesn't really matter.

-- PMM

