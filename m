Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C38C5CC2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 23:28:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zfr-0004im-Ij; Tue, 14 May 2024 17:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zfl-0004dl-7B
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:26:58 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zfi-0003mA-HC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:26:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4FBE4CE130A;
 Tue, 14 May 2024 21:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E3C2BD10;
 Tue, 14 May 2024 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715722010;
 bh=gEM9zjywMYuNlwNSRMGSQ++BieAVZG2RhB1dCv3+xV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A4mGjkUSxPqmt7CX62q6D9qY+qa3ZNaxutov1LLT6o3kvNdsEIIRgmCvZu6Y1x3pk
 2ivY6qw6XGnwHO/0pEerD8smVR/90rXdPMmVPhmUHJwnWnqWjT2tMJJOTaXbugQjNr
 ImhXycAyQMF1oLvfam4FdZaWiDzm/P4Nf0PkuwnV8qoC7D18aNFWWfW5BEjbBanjSn
 0S9I2VftLA9D7IaMKczIEalaqWqyVUsGVgeZJIXTzQnSAvZIRM3PzBfK51W0gdDGKs
 gBo4otjws2lrn0ca4CqdcS0yq7VgeW6GDkXT6CTLK997S+XabFylhy2t1MPo6OwfM5
 hbZ7q4SNFlIjg==
Date: Tue, 14 May 2024 23:26:45 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 40/45] target/hppa: Adjust priv for B,GATE at runtime
Message-ID: <ZkPXFbi47asrT30x@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-41-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-41-richard.henderson@linaro.org>
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
> Do not compile in the priv change based on the first
> translation; look up the PTE at execution time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

