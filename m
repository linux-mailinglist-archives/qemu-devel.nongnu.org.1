Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9950D7423BD
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEoad-0004e7-5o; Thu, 29 Jun 2023 06:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qEoab-0004dp-7c
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:09:25 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qEoaZ-0003IE-De
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=30JWqZxAK5X4DfyIvS6YM/B2HN99QJ8uT6S9KfIn9VI=; b=CKkXXZ4ayFZPNPVnVJ+s5yauU8
 Mfd1/RFC8d5cEwMXTPxXZz0GJoYXez5NYVIP9cEXodKPotYBq1bzonv1sm96oghzV6bQJiUwuhCHg
 YGCgMCHGfiUYQSVspZXlbINzNqKkP1V/tqZ+D1I+KQmhH3vo1k/xjD9u/z3HCKguwYSGgwlOcnax2
 FS2SoDNoFPl8EGqVF7wObNEi8/VpSEL43/6Z41bXO4tQqgHl3K85CWRKj4Y0tuAafU7H7rkrLtW1D
 498gb00GD6NaSWhRFrY+9aYOdPgsgTzzGAb1qNrIi5YdsrVcSQIja45XCaIfCSzfg+4zdJ2hOmxRN
 DOdt7h4nSpiGNFASmcL6+kXL5ExN4RNVCi9xFElPRsRF21Cej6I474YrR2oiUeYAt7mou0ioKmQ4m
 WhGCc6dDfJda4vt+UfjwcU5p3Ad896oG04Qr81ZGglGz7aN1WCQm7bccKfbuNGtXQubcM31eeGQuC
 4HD9/NOu5msTcrHdJN3HmpfEhPUYwrdSpOXAk4rMb2EXF7Hiun30DNJH6VSaiHU1QeA22DnSJmi7+
 0Mc/PgIKOryeHyjgUTSo31nsoE7sRYqLWUA07k2AqnlX4hAvCyDqahZEmP52vw6QEvmWV3r1G7r4L
 Q9V+B0Kb73+H2XshnTi1zZTxWmEaCWJ/khA/cIxUw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5] 9pfs: deprecate 'proxy' backend
Date: Thu, 29 Jun 2023 12:07:43 +0200
Message-ID: <9758911.ANVE0QeqSM@silver>
In-Reply-To: <E1qDkmw-0007M1-8f@lizzy.crudebyte.com>
References: <E1qDkmw-0007M1-8f@lizzy.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Monday, June 26, 2023 1:49:06 PM CEST Christian Schoenebeck wrote:
> As recent CVE-2023-2861 (fixed by f6b0de53fb) once again showed, the 9p
> 'proxy' fs driver is in bad shape. Using the 'proxy' backend was already
> discouraged for safety reasons before and we recommended to use the
> 'local' backend (preferably in conjunction with its 'mapped' security
> model) instead, but now it is time to officially deprecate the 'proxy'
> backend.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  v4 -> v5:
>  - Eliminate repititve use of word 'instead' in text.
>  - Commit log: mention exact commit which fixed CVE-2023-2861.

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

Best regards,
Christian Schoenebeck



