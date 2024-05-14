Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4158C5CBE
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 23:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zbP-0002X8-H5; Tue, 14 May 2024 17:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zbJ-0002Ws-IJ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:22:21 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zbF-000261-QC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:22:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1C918CE118C;
 Tue, 14 May 2024 21:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E92C2BD10;
 Tue, 14 May 2024 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715721733;
 bh=UYqnnHRHGf0pNNFr0ABqSZk7vPywFRdcPobQyrmBDJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vPuHJCnJD4nz2KiYsMDzQ6KxOLmKQU4GZ+VgFEp96ZtHnAjjTyNiYtMVOCkhjMiAR
 1So6xvXpjQRUN98I0/UTTJ58yBTIujPMvWDXI1s2QyaS+pQt9cGsHJPRSo2u7KYq18
 oJtfaWRFPzd3VhKSBceL+Hi+Fw1uxqKTQYREl3kqeKpLQbeAMtfMc6HDpldEaTur3M
 kUekxEjCxTetrFOGuDumJw+NrUok6rOp+m/8tFj8CpSL5C8VDelZWshhurujoIe1y2
 +jSf5+IEbzrAoyEwp8Bai3cPmAC712fkIsC+KaQe77Hh+W7BTAS1jt/7YKjPrqeZCr
 8I3VHZ0aIXtlA==
Date: Tue, 14 May 2024 23:22:09 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 38/45] target/hppa: Implement PSW_X
Message-ID: <ZkPWAbM6_4cahLbh@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-39-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-39-richard.henderson@linaro.org>
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> Use PAGE_WRITE_INV to temporarily enable write permission
> on for a given page, driven by PSW_X being set.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

