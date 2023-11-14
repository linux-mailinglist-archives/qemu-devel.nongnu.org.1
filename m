Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426F7EAAFF
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 08:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2o3y-0005wp-Fv; Tue, 14 Nov 2023 02:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2o3v-0005wU-U8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:42:19 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2o3s-0003ds-UQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:42:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso8127567a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699947735; x=1700552535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afwXf5UyfyHio4t/MoTziNc/oom0veIJS2FP26Ef0EA=;
 b=INSJog/tP7iFUyoEYA4aOoU7iNXWkpBWfNn/Gse+nWo4j+SrQxmy8Hr/dkzmWaEUI/
 pxRfh4XXGoifIODGiKw7rOvLjdwTmJ/AZSyGg1G+zC8mlI9iACjbfBBjZXUyq2PTeaH/
 llZeT31xPkxyjLPz5n1tmUeW2fC2FJ/V9CkyXMaw1q3p112tGOiJrIraifTLqD0+4eND
 0tAKmx/rzmm56joWUjGc5bnJzGxzICNPz5yrX4kTNyKfVLqI4sWlX2fOuofKoisDRD4p
 MbZ9+dl9LXKtc9bhZKfy0G4JndKElgsl5WbxuN9fWU75ZK9sNOeqPAfsR0rIIHgIs0qg
 I30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699947735; x=1700552535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afwXf5UyfyHio4t/MoTziNc/oom0veIJS2FP26Ef0EA=;
 b=F9lkViww3ZF/dfgEJ1URB70EikYSHzCCKtVZTcq846WcbV/Z7FvyqStqsIK1vAZPEJ
 f8BsFlL3F7rfwbnHCw7jV2XDSEguvnBtq0jzVlzvgY4FM8oN6sYAZbgtknFzu2XTkcqK
 LD7meoNG5m+N+mCOJNYKjU5FNVPTylhPSOLUf5Q4dvYl1kejaSct58g5XBnFLaGUMXPV
 siGKbpVo/u0diX9QLi3I6redgWAP9nHDgry9lAhSEp7H59eZ6SigelDKG8/pg8/sWRsO
 NxEGQHP7gumUGHL82q4E4Tofu0/E2oKMBDDN8U7+3vB7Goghgn6FPX5Nhsgn59zXvtgF
 VbLQ==
X-Gm-Message-State: AOJu0Ywr4hudTBtSVu9wAWcG5NrpOvUdZdvVaRgOKDWkh4l1BiBE5f3k
 06nHCZ0YKPkJaPe0agvQM/PyT3nDRkwGtsw9IQ0=
X-Google-Smtp-Source: AGHT+IFce6dsUWO8qArRxaXq4VW8P2txycNkeinwY/EAXtRKE4RItRlBpr4najyISG4uncQiB0ABBQ==
X-Received: by 2002:a05:6402:884:b0:545:5674:4293 with SMTP id
 e4-20020a056402088400b0054556744293mr6387649edy.28.1699947734901; 
 Mon, 13 Nov 2023 23:42:14 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 er22-20020a056402449600b0054130b1bc77sm4739041edb.51.2023.11.13.23.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 23:42:14 -0800 (PST)
Message-ID: <e6680657-59de-4845-a3a3-af8df11fc443@linaro.org>
Date: Tue, 14 Nov 2023 08:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/10] hw/xen: Factor xen_arch_align_ioreq_data()
 out of handle_ioreq()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-5-philmd@linaro.org>
 <a50b0790-03d7-458c-834b-907e130bb5fd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a50b0790-03d7-458c-834b-907e130bb5fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/11/23 19:16, Richard Henderson wrote:
> On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
>> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
>> index c028c1b541..03f9417e7e 100644
>> --- a/hw/xen/xen-hvm-common.c
>> +++ b/hw/xen/xen-hvm-common.c
>> @@ -426,10 +426,7 @@ static void handle_ioreq(XenIOState *state, 
>> ioreq_t *req)
>>       trace_handle_ioreq(req, req->type, req->dir, req->df, 
>> req->data_is_ptr,
>>                          req->addr, req->data, req->count, req->size);
>> -    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
>> -            (req->size < sizeof (target_ulong))) {
>> -        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
>> -    }
> 
> 
> I suspect this should never have been using target_ulong at all: 
> req->data is uint64_t.

This could replace it:

-- >8 --
-    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
-        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE)) {
+        req->data = extract64(req->data, 0, BITS_PER_BYTE * req->size);
      }
---

Some notes while looking at this.

Per xen/include/public/hvm/ioreq.h header:

#define IOREQ_TYPE_PIO          0 /* pio */
#define IOREQ_TYPE_COPY         1 /* mmio ops */
#define IOREQ_TYPE_PCI_CONFIG   2
#define IOREQ_TYPE_VMWARE_PORT  3
#define IOREQ_TYPE_TIMEOFFSET   7
#define IOREQ_TYPE_INVALIDATE   8 /* mapcache */

   struct ioreq {
     uint64_t addr;          /* physical address */
     uint64_t data;          /* data (or paddr of data) */
     uint32_t count;         /* for rep prefixes */
     uint32_t size;          /* size in bytes */
     uint32_t vp_eport;      /* evtchn for notifications to/from device 
model */
     uint16_t _pad0;
     uint8_t state:4;
     uint8_t data_is_ptr:1;  /* if 1, data above is the guest paddr
                              * of the real data to use. */
     uint8_t dir:1;          /* 1=read, 0=write */
     uint8_t df:1;
     uint8_t _pad1:1;
     uint8_t type;           /* I/O type */
   };
   typedef struct ioreq ioreq_t;

If 'data' is not a pointer, it is a u64.

- In PIO / VMWARE_PORT modes, only 32-bit are used.

- In MMIO COPY mode, memory is accessed by chunks of 64-bit

- In PCI_CONFIG mode, access is u8 or u16 or u32.

- None of TIMEOFFSET / INVALIDATE use 'req'.

- Fallback is only used in x86 for VMWARE_PORT.

--

Regards,

Phil.

