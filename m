Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D5746FD3
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGe8Q-0008Dj-HZ; Tue, 04 Jul 2023 07:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qGe8N-0008DL-2E
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:23:51 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qGe8L-0001ZZ-1X
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=HehWFw8+KZ+cL/1fmCslrE+C80fViBYed29H862S9Co=; b=onex75+CDNlMkvvGCt5+RGX4rH
 SGT1o2vX6Ka74mCFgTSAaf6z3TgSQhi8BFKcC+3xEaB5PtTUMbTqCZByqRVq3ugwiX/ER4x12myjm
 p3dSwVGXft02dj6QfsXyYC1MZ/hd7yYdaMLsZHyHVMXJJdPt99LC9VNBEEEA6iBvxHVnD1+NC+ZPo
 zp/v7zMDXsaeYqoASdHli/z9bYy27J/9Z1VUCHvfTg3Qi6BWtWq30/S9/nAiDYIjFumgPx+gtXu3H
 s3CZLoFHdyp+PBgkiP2q+wbdjbyQp8nvyH2q7MxugxlW5nOY5lhOTaRUItNbRs2xEV7PWtBRITsmQ
 NfDvndFaXTSqboMO4svTbOFY6+AW6J49eQZyYQ1XkhaQmvAQGMUgD7fTr2L/p/fD3DTLR95TNFSoq
 NFw/Fjpm0ClqUWhggSEJrtmCqAhA9TjFz0jMEH9mkxwN96+tr/NIUffpn2cvpZI9ChmDXuBbxzr6o
 lmnZoP94xFr3bckMZ+JIX4BHHFtWCJ42WSK4+V93gzy9/ClsPfIKoYKKNbV3xx5QTrnexOml9WLTk
 lUwHO8WCMHymhIM2R8YWH78VsCrR8IAxmRQUqH7oNTrLcdEXHcPvnL31VU1PNJshhqt/eETErpeDW
 0Ik37idpDTP059Bqed5p4PlQ1Ix5/F/tKM5ygOeWw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: raise status of 9p to 'Maintained'
Date: Tue, 04 Jul 2023 13:23:43 +0200
Message-ID: <2068130.UnAGF4QcSV@silver>
In-Reply-To: <20230703165042.4e5e81cf@bahia>
References: <E1qGKgV-0003Hj-01@lizzy.crudebyte.com>
 <20230703165042.4e5e81cf@bahia>
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

On Monday, July 3, 2023 4:50:42 PM CEST Greg Kurz wrote:
> On Mon, 3 Jul 2023 16:34:17 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > Change status of 9p from 'Odd Fixes' to 'Maintained', as this better
> > reflects current situation. I already take care of 9p patches for a
> > while, which included new features as well.
> > 
> 
> Thanks for the good work ! :-)

And I have to repay that tribute to you as well of course, thanks for taking 
care! :)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

Best regards,
Christian Schoenebeck



