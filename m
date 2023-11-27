Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FD7FAB97
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCU-0003XI-3V; Mon, 27 Nov 2023 15:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7iCH-0003Js-BL
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:13 -0500
Received: from skyblue.cherry.relay.mailchannels.net ([23.83.223.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7iCC-0002pR-Nl
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:13 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 2586D7640D1;
 Mon, 27 Nov 2023 20:27:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a286.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id B9F007640D8;
 Mon, 27 Nov 2023 20:27:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701116825; a=rsa-sha256;
 cv=none;
 b=uX3G38nDjTOTjZe16G2geCo8prooPraIm29Z8ghLDQykiS08zPZlZeKqHJTvc4kROeDat9
 7ONrCUUQSTcYszf+qy8kIJu9mGV8bxpycyxbROEw98DSejUm/YC/75g48nFWXGpRBOjHoS
 26V68D5ltdq54hj2qKCgTc6u4HUWQ3qsswbiuAFOU5XK8aDYiv6mv5OCdwlc9Nk6Fwc4n8
 7xNwePiBOivZS/SlRxyjXe/faVMM+M2q9q4y+T5UDggvTY6wiG/DgeiqYGypZPN/MnGjX4
 W7FjDAtimnzk5bjNIoNMKjgQR+qVKL/mb7Z8tWOedaeHI5eIUwtCcXotA4QO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1701116825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=YpwJmVd6w/yQL7xP9tpzIk872rGRPU1cjm3LMRcfYm4=;
 b=pQ+QprRL4e7+bYao6vEjswJJDIeuDztgc9Akr0U98GP3BAGbaewr78pCqB+P0td/8+I2b5
 yVdPkDTFsdE4mZ/sYCzZZ0wCa2Q5qzru3WSdvjKbD3dMECOg+2QFqDFrTqOwlEtBNYk4I0
 QjCM+p5ntxoCxozMPCRwtpxikXsiHi1Eom/CrPjqFPw4WXIFbFQjqpGBP+3dOik546cY3k
 gaD5ahEUMQsemS+3D0znOhWnZkJ+ZBFZeaCuVE9i477vy3uRJWYskUUd4290cYNFRixnlX
 HfkXS9Uzk/Eq+8jayFMnYSvt6UiNeKd3vBJZVYwLrK5KbhkEG55WYYh6JpagvA==
ARC-Authentication-Results: i=1; rspamd-d88d8bd54-5frn4;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Occur: 623aa40065f41578_1701116825931_4201577544
X-MC-Loop-Signature: 1701116825931:2145607999
X-MC-Ingress-Time: 1701116825930
Received: from pdx1-sub0-mail-a286.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.120.2.6 (trex/6.9.2); Mon, 27 Nov 2023 20:27:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a286.dreamhost.com (Postfix) with ESMTPSA id 4SfHF51LmgzDG; 
 Mon, 27 Nov 2023 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1701116825;
 bh=YpwJmVd6w/yQL7xP9tpzIk872rGRPU1cjm3LMRcfYm4=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=GBRF42tO3IB66eEHJVjxpne2xtm++GCfysWJPJhLtSHy+i65kmKYEwdQyadxHUgcL
 /dafWWjlZGxtnvpz8JeuwkUIZVDThcYEEO1wUIGkUlC+/ow3kWgaba2n3HGQmZI1Ek
 tyrfWTWU0HGMS2N11Uu4Ok7LIQvcWeuYiohRo3pb2x+e1SVxuwcgLBJN2kbbjeEfJH
 zmMJ68HCixaBEW50o1ehthbFKwoAil5VSRl/zMtD9dslES5ZJmSLaNIRDuzQyS/vmq
 bQtoiQadN4vlO1crS4oUTgspYWIagobfmrtPxl8ha+9K2SoJ3hL2Il4TTCzv4Im++H
 r/LbPnM9MKK2A==
Date: Mon, 27 Nov 2023 12:27:02 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-cxl@lore.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20231127202702.zkqomoapz2iprpra@offworld>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-2-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231127105830.2104954-2-42.hyeyoo@gmail.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.223.167; envelope-from=dave@stgolabs.net;
 helo=skyblue.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:

>In the current mdev_reg_read() implementation, it consistently returns
>that the Media Status is Ready (01b). This was fine until commit
>25a52959f99d ("hw/cxl: Add support for device sanitation") because the
>media was presumed to be ready.
>
>However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
>during sanitation, the Media State should be set to Disabled (11b). The
>mentioned commit correctly sets it to Disabled, but mdev_reg_read()
>still returns Media Status as Ready.
>
>To address this, update mdev_reg_read() to read register values instead
>of returning dummy values.
>
>Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
>Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks good, thanks.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

In addition how about the following to further robustify?
   - disallow certain incoming cci cmd when media is disabled
   - deal with memory reads/writes when media is disabled
   - make __toggle_media() a nop when passed value is already set
   - play nice with arm64 uses little endian reads and writes (this
     should be extended to all of mbox/cci of course).

----8<-----------------------------
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6eff56fb1b34..9bc5121215c9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1314,6 +1314,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
      int ret;
      const struct cxl_cmd *cxl_cmd;
      opcode_handler h;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
  
      *len_out = 0;
      cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -1334,8 +1335,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
          return CXL_MBOX_BUSY;
      }
  
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
+    /* forbid any selected commands when necessary */
+    if (sanitize_running(cci) || cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
          if (h == cmd_events_get_records ||
              h == cmd_ccls_get_partition_info ||
              h == cmd_ccls_set_lsa ||
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 72d93713473d..e0a164fde007 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -899,7 +899,8 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
          return MEMTX_ERROR;
      }
  
-    if (sanitize_running(&ct3d->cci)) {
+    if (sanitize_running(&ct3d->cci) ||
+        cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
          qemu_guest_getrandom_nofail(data, size);
          return MEMTX_OK;
      }
@@ -925,6 +926,11 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
          return MEMTX_OK;
      }
  
+    /* memory writes to the device will have no effect */
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
+        return MEMTX_OK;
+    }
+
      return address_space_write(as, dpa_offset, attrs, &data, size);
  }
  
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 873e6d6ab159..007d4169df7c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -349,14 +349,26 @@ REG64(CXL_MEM_DEV_STS, 0)
      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
  
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
+{
+    uint64_t dev_status_reg;
+
+    dev_status_reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
+}
+
  static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
  {
      uint64_t dev_status_reg;
  
-    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    dev_status_reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
+    if (FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == val) {
+        return;
+    }
+
      dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
                                  val);
-    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+    stq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS, dev_status_reg);
  }
  #define cxl_dev_disable_media(cxlds)                    \
          do { __toggle_media((cxlds), 0x3); } while (0)

