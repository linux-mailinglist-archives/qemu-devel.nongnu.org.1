Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54374EA3F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9Zf-0002cN-BS; Tue, 11 Jul 2023 05:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJ9Zd-0002cF-3t
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJ9Zb-0005v6-Lq
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689067338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S05ywxmDG/S4bUS/YWXYM6BzidRIknNHfhea/ObC44g=;
 b=gJKAouMd8HluTFJxSzSl1QWWwNxSxXx8lsqXzETx9ERrQ8ZLR1mAxaGDsLKc/uU4lDCQfL
 1yCRTSzm/MQ6JxmmpfTLtWicbJvTUt29clR390wqe5gnwmlL3rLLPKrgoLGtSDfMpeI7D7
 MaYA0OIECnlXOoF/JvRDKCTn7MEna/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-hcA9ELgOP4ur-f6HuoiitQ-1; Tue, 11 Jul 2023 05:22:12 -0400
X-MC-Unique: hcA9ELgOP4ur-f6HuoiitQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbfc766a78so27278625e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689067331; x=1691659331;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S05ywxmDG/S4bUS/YWXYM6BzidRIknNHfhea/ObC44g=;
 b=JH0pQigogbjix1fgXDsdUF7/QPNO/RUaHtRPQP3jot5Xf4d1nSfRzOq33bmA+RvmZH
 th4lSJlxSjbWeKFssU0sqRG5xDbJhqfGsgTXxiYGJAzVZJz/UgmIRB9GkKFkPGZ0xhZ0
 Rhoaxkya0t19IBDS/Z0ccUVor+L/zhb5Ki5EzbF+Qri66123sVh9FXdeuWqEOva/5zNM
 sfi4T90n8oDT3qbgTRueGWcpttU+V6mDQfwtjnTM1a9LnUwxsgShfnjDEWYGnsa9KaN2
 5av905i1MUkOTQqU5RAJRFjFrShVCE0HAvrClR6bNh5PrZ7eRpWr2ZfWVcEDjNV1jbbh
 ccpA==
X-Gm-Message-State: ABy/qLbyjo+y4YRB/l2qvFKKJ5H+KEO3ePD+/OpUx5c+2N3fmZQN90E6
 Ce0uwkAAX8lf0K/bcQqKACFzS9DIEpAlIlDXzRbiUKpmOndkZuWiA/a4cdDfwu8X5rqjdUmD9x6
 Xk/vUgOLimKMSj5w=
X-Received: by 2002:a05:600c:20cb:b0:3fc:f9c:a3e2 with SMTP id
 y11-20020a05600c20cb00b003fc0f9ca3e2mr6726358wmm.6.1689067331474; 
 Tue, 11 Jul 2023 02:22:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3sp5NJhqXT7UgwqWV/V8Jyie7X11Mx1K8MDdNIR8FRdU5j67nA2dReq2O7ZqTH86bES4iPg==
X-Received: by 2002:a05:600c:20cb:b0:3fc:f9c:a3e2 with SMTP id
 y11-20020a05600c20cb00b003fc0f9ca3e2mr6726340wmm.6.1689067331133; 
 Tue, 11 Jul 2023 02:22:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d?
 (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de.
 [2003:cb:c745:4000:13ad:ed64:37e6:115d])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d53c5000000b002fb60c7995esm1744300wrw.8.2023.07.11.02.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 02:22:10 -0700 (PDT)
Message-ID: <840d704e-879e-5d13-5bef-038d275e038d@redhat.com>
Date: Tue, 11 Jul 2023 11:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230710100714.228867-1-david@redhat.com>
 <20230710100714.228867-4-david@redhat.com>
 <20230710173933-mutt-send-email-mst@kernel.org>
 <b9351bf7-cabd-784c-bebc-a18a9b3f4bc1@redhat.com>
 <20230711044647-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 3/7] arm/virt: Use virtio-md-pci (un)plug functions
In-Reply-To: <20230711044647-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11.07.23 10:47, Michael S. Tsirkin wrote:
> On Tue, Jul 11, 2023 at 10:32:31AM +0200, David Hildenbrand wrote:
>> On 10.07.23 23:40, Michael S. Tsirkin wrote:
>>>> @@ -2855,12 +2796,11 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>>                                         SYS_BUS_DEVICE(dev));
>>>>            }
>>>>        }
>>>> +
>>>>        if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>>>            virt_memory_plug(hotplug_dev, dev, errp);
>>>> -    }
>>>> -
>>>> -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>>>> -        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>>>> +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>>>>        }
>>>>        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>>>
>>>
>>> How is this supposed to link if virtio-md is disabled at compile time?
>>>
>>
>> Good point.
>>
>> The old code unconditionally enabled MEM_DEVICE, so we never required subs
>> for that.
>>
>> We either need stubs or have to wrap this in #ifdef.
>>
>> Stubs sound cleaner.
> 
> That is what we usually do, yes.
> 

I'm testing with the following:


diff --git a/stubs/meson.build b/stubs/meson.build
index a56645e2f7..160154912c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -65,3 +65,4 @@ else
  endif
  stub_ss.add(files('semihost-all.c'))
  stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
+stub_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio_md_pci.c'))
diff --git a/stubs/virtio_md_pci.c b/stubs/virtio_md_pci.c
new file mode 100644
index 0000000000..ce5bba0c9d
--- /dev/null
+++ b/stubs/virtio_md_pci.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/virtio-md-pci.h"
+
+void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
+                                  Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}
+
+void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
+{
+    error_setg(errp, "virtio based memory devices not supported");
+}


For now (not having virtio-md-ccw or virtio-md-mmio) this should do the trick I think.

-- 
Cheers,

David / dhildenb


