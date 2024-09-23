Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182897BF61
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 19:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqy2k-000179-Sk; Wed, 18 Sep 2024 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sqy2g-00016N-N3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:00:38 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sqy2f-0000gR-Ag
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=OApo4NZyenOronrEb3v7/OGB35zGeuzFbz8cMutWSgs=; b=AV3gTxzQxEuCDx8J
 UySTu0zRqmmjuHnMPOP8MkWGOjCtgadOCdZUJ3c48oPquwVY1kvXPsBQKABiCH2iRoRL9vMDk88nw
 8sqAROqm3dXH8zNgzUydjRJ9qPqwScYbL/gBWrBnFMvD0lnRJCPItazQjb9/Qvmoymmji8m3LF+nu
 w55Jb63yxjPup/isT2vhB2uc91dwWmhHuXpL4ph5vCOYeDJu8Vd+lX9+6T873StLQlw2vbKhqobV+
 zyGGIxi+Yh9H8N4Rfp0F82MBxN6PJ0q+DDHwk5/dU8zvmoJO5a9fYmOLlGpmU+QmPzOCZuYl8U/XX
 BOis9J40j08BaOdSrg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sqy2b-006K20-2T;
 Wed, 18 Sep 2024 17:00:33 +0000
Date: Wed, 18 Sep 2024 17:00:33 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: jag.raman@oracle.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: of remote_iohub_finalize
Message-ID: <ZusHMRnxjeS5qOd6@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:57:25 up 133 days,  4:11,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, SUBJ_LACKS_WORDS=1.744 autolearn=no autolearn_force=no
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

Hi Jag,
  One of my scripts noticed that 'remote_iohub_finalize' in
hw/remote/iohub.c is unused; before I go and delete it as deadcode,
is that actually just a missing call somewhere?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

