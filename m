Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EA37E47EB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:11:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QX8-0004IR-Nt; Tue, 07 Nov 2023 13:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QX6-00042X-7C
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWp-0002ii-JB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso41925735ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380616; x=1699985416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=872NT2jnFhG8wm8+lD3t3/U5wszznBHMhw38Vv5CsDA=;
 b=lIfl9jTVUVZw84e65d5mTC575pcfEK0hlm2vNZMexyr2W32NIHAh298JjxB0Og8FKP
 GXbVMQ/52wPvFmO3EEuws1NkbmO2Iv5wJGuoyz7c1dnLBsD+I6BLH/aC6rtex9oj94AC
 sBF2vX7wGX6H3kO5cmoMj9qa++I9DyTcenc4pqUPbfExKtFgnUV6p2VmjLKgFqorKoC1
 vhql/JNXVydtWXmxjNUvmG+OsFHuMYozg6YwcJQXqvS+KfKvwklSuTHEroQURLyjjgmH
 vivlbVieiocBI5RWH2c144OFNwMmxXRf0Yx42XnULV469KpKztI2Fjqu2bBhj61hgGMK
 oSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380616; x=1699985416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=872NT2jnFhG8wm8+lD3t3/U5wszznBHMhw38Vv5CsDA=;
 b=KthNoS12vRuhEPDvxbhatqMlymegvpCuNajI9AJmOg30MeDW5am3hp5sx1hzYpe3Q+
 5YBc3EZHkFXTPlcMflScNDhwOMbqsRpTgF7vX9yAT4if2epVXRTOgsqiwWyEXYO/51s1
 OLG50KsZku61tYZ7xlRMVYJLyF9C7hZb70Ovt0g1mCoRTX6Vzw8Xr0qRpHMeMkJUeStI
 QZ2qyYNOzASNLdWDT+VEoAXsFsZYaXhq7HMM+XPu1eN0T/KRTjf70YoRD05mp40y09gy
 8IK/eQENAg6+R+c+KZAggx0JT0sF0O+yTBTC/CW05oci7Q1QebFGxFL4rb+h7CYjy8ft
 6X/Q==
X-Gm-Message-State: AOJu0YwRVWMtbWKuHCBYlcYwQKYABaEWwT/8FgtIBrnycQq1aRNQ7qZ3
 eoxX9i5QNhwWO0f2gNFywFyb4Bdwk+g=
X-Google-Smtp-Source: AGHT+IGpDAZuTY89vqYjA1pQEMeZEpOFC5R0rLXifr2HHa+PlrsdY39ctuA83JReZ0sT3cFCfOZqjQ==
X-Received: by 2002:a17:903:124a:b0:1cc:ee07:1659 with SMTP id
 u10-20020a170903124a00b001ccee071659mr4218910plh.46.1699380615908; 
 Tue, 07 Nov 2023 10:10:15 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:15 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <nifan.cxl@gmail.com>
Subject: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Date: Tue,  7 Nov 2023 10:07:04 -0800
Message-ID: <20231107180907.553451-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fan Ni <nifan.cxl@gmail.com>


The patch series are based on Jonathan's branch cxl-2023-09-26.

The main changes include,
1. Update cxl_find_dc_region to detect the case the range of the extent cross
    multiple DC regions.
2. Add comments to explain the checks performed in function
    cxl_detect_malformed_extent_list. (Jonathan)
3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
4. Update total_extent_count in add/release dynamic capacity response function.
    (Ira and Jorgen Hansen).
5. Fix the logic issue in test_bits and renamed it to
    test_any_bits_set to clear its function.
6. Add pending extent list for dc extent add event.
7. When add extent response is received, use the pending-to-add list to
    verify the extents are valid.
8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
    cxl_device.h so it can be used in different files.
9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
    log type.
10. Extract the functionality to delete extent from extent list to a helper
    function.
11. Move the update of the bitmap which reflects which blocks are backed with
dc extents from the moment when a dc extent is offered to the moment when it
is accepted from the host.
12. Free dc_name after calling address_space_init to avoid memory leak when
    returning early. (Nathan)
13. Add code to detect and reject QMP requests without any extents. (Jonathan)
14. Add code to detect and reject QMP requests where the extent len is 0.
15. Change the QMP interface and move the region-id out of extents and now
    each command only takes care of extent add/release request in a single
    region. (Jonathan)
16. Change the region bitmap length from decode_len to len.
17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
    (Jonathan)
18. Block any dc extent release command if the exact extent is not already in
    the extent list of the device.

The code is tested together with Ira's kernel DCD support:
https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30

Cover letter from v2 is here:
https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf

Last version (v2) is here:
https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/

More DCD related discussions are here:
https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/



Fan Ni (9):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions

 hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  64 ++++-
 include/hw/cxl/cxl_events.h |  15 +
 qapi/cxl.json               |  60 +++-
 6 files changed, 1123 insertions(+), 47 deletions(-)

-- 
2.42.0


