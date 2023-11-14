Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAE7EB2A7
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:42:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uaf-0005Jm-Tt; Tue, 14 Nov 2023 09:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ua1-0004k7-GE
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:56 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZz-0007yJ-LF
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:53 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507adc3381cso7602155e87.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972788; x=1700577588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5X2FluBMHtEHwLVURbcbmArZUeMN34wqMB+9uG3SGg=;
 b=gSTJ8Rvicj7iLETfyXC1+AX3u8+ZGZasmJlL75B5tcBGBcP+xw2ZbBkLSN6ak70pi1
 hKU1Vgo7AjpBIhj4hxcGMQQnUUAJGfZAKgeN+SbDH572XVjU5osjXeOXKgRUCRZ9p+lk
 728vne7r2Lg+VJrCqtodMYJ8EoKPDkl06w3OggPf0dEEPnWpXg7Cg0kO6P8U5HFXrfRS
 iz0ds24y6FmYo3j240BlKtHSMil71T6qboigv9WD5hIZI17x0ShJ/UrtxQVcYpmuNjqv
 Yds4ys3D/joJTzfXNMzyV4TBXDuCqHi+TvoFpqC/d/6h273kla5l7Ek9IfeNC9qbN3Wt
 Wa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972788; x=1700577588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5X2FluBMHtEHwLVURbcbmArZUeMN34wqMB+9uG3SGg=;
 b=vfIfFshe2wM8AkV3vG2g321qc7Qgu15CL6V8UZqU19H2qQkuK564ssAuQaAGbBFprt
 StGpw7LitrZpMYyQXx9iwdkt3GpLr7hwV2MDNKWC0f4YMjs03RoybtjmT2SgZHdl2RO4
 jbl0JSTOy3QNYK2HJ2ptbR2HWcF3G04q5Wh5mzRobzsFz6aaWrj/rjCONayku/cn/WnC
 DM0nUJiM1GdNFjkL9iX+AZUD43Wg8XXshOjQ2xL8yLHZ6/upGy1HLQSYKN0gHZ/J/nV8
 p2lgSksTv9N4CS5QUva5y+635asAc+aRCtwaaEUKfZ5ZUS5kXb6iFmi6mtS2UYZUOEGJ
 aahw==
X-Gm-Message-State: AOJu0YzqZDOaqprcNpl9tBGkO5MGu0JEtPCOje4sFaMFixnPtvodY3u0
 JavtgYe8Gf4FIcYqT6rVO3Ylxw==
X-Google-Smtp-Source: AGHT+IEJ1DzMQPrVK6vmcQ1s/BHFe+ZR138ty+E3IEfmXhpEvhlt8hMy3AYRKnboRNNE1Pe2RYsE2w==
X-Received: by 2002:a05:6512:b14:b0:509:8e3d:7cb0 with SMTP id
 w20-20020a0565120b1400b005098e3d7cb0mr9400030lfu.41.1699972788532; 
 Tue, 14 Nov 2023 06:39:48 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 l18-20020a50d6d2000000b00542db304680sm5268842edj.63.2023.11.14.06.39.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.0 v2 13/19] hw/xen: Remove use of 'target_ulong' in
 handle_ioreq()
Date: Tue, 14 Nov 2023 15:38:09 +0100
Message-ID: <20231114143816.71079-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move common
function to xen-hvm-common"), handle_ioreq() is expected to be
target-agnostic. However it uses 'target_ulong', which is a target
specific definition.

Per xen/include/public/hvm/ioreq.h header:

  struct ioreq {
    uint64_t addr;          /* physical address */
    uint64_t data;          /* data (or paddr of data) */
    uint32_t count;         /* for rep prefixes */
    uint32_t size;          /* size in bytes */
    uint32_t vp_eport;      /* evtchn for notifications to/from device model */
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

Masking the upper bits of 'data' to keep 'req->size' low bits
is irrelevant of the target word size. Remove the word size
check and always extract the relevant bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index bb3cfb200c..fb81bd8fbc 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "trace.h"
 
@@ -426,9 +427,8 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
     trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
                        req->addr, req->data, req->count, req->size);
 
-    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
-        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE)) {
+        req->data = extract64(req->data, 0, BITS_PER_BYTE * req->size);
     }
 
     if (req->dir == IOREQ_WRITE)
-- 
2.41.0


