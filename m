Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC11829718
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 11:15:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNVai-0005Ft-G0; Wed, 10 Jan 2024 05:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1rNVae-0005FW-Sd
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:13:40 -0500
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1rNVac-0004Hd-5N
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:13:40 -0500
To: <gaoshiyuan@baidu.com>
CC: <kvm@vger.kernel.org>, <mtosatti@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] kvm: limit the maximum CPUID.0xA.edx[0..4] to 3
Date: Wed, 10 Jan 2024 18:13:17 +0800
Message-ID: <20240110101317.46344-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230602073857.96790-1-gaoshiyuan@baidu.com>
References: <20230602073857.96790-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.22
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.202.115.85; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyuan Gao <gaoshiyuan@baidu.com>
From:  Shiyuan Gao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Anyone has suggestion?

When the host kernel before this commit 2e8cd7a3b828 ("kvm: x86: limit the maximum number of vPMU
fixed counters to 3") on icelake microarchitecture and newer, execute cpuid in the Guest:

Architecture Performance Monitoring Features (0xa/edx):
    number of fixed counters    = 0x4 (4)

This is not inconsistent with num_architectural_pmu_fixed_counters in QEMU.

