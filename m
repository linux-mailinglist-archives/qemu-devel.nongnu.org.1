Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220B78FEAC
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 15:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc4er-0005ij-Db; Fri, 01 Sep 2023 09:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc4ep-0005iL-Mh
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 09:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc4en-0005XL-Ld
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693576671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ugp6SCBZR9psXeSoW2ZQzafy94U8T8Cz4IjpAts8YY=;
 b=LA9xjwLxILEt3FcMsyZovs0XIUgCN2hmASGR98c4rm6sP3T1H+dZjteszWdOdgGQdOOxJn
 k184vxOYvnEsV8ufOcauHiN2562n/ct8OpswR39DOZ+3ngIaRbpd0GmzppzdD1mLKwhYUW
 m/2x9H7rHEZBbLTyuhiX7O4NtKPhPEY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-l3Q01sL0Nw60ONqmZdyjEg-1; Fri, 01 Sep 2023 09:57:47 -0400
X-MC-Unique: l3Q01sL0Nw60ONqmZdyjEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1873B3C1DC21;
 Fri,  1 Sep 2023 13:57:47 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1B73493110;
 Fri,  1 Sep 2023 13:57:45 +0000 (UTC)
Date: Fri, 1 Sep 2023 15:57:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] fix bdrv_open_child return value check
Message-ID: <ZPHt2DzGsNeIg3w3@redhat.com>
References: <20230831125926.796205-1-frolov@swemel.ru>
 <ZPHH3N8RiMxNa13F@redhat.com>
 <483510b6-dc31-c53c-b114-03aa249c3478@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <483510b6-dc31-c53c-b114-03aa249c3478@swemel.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 01.09.2023 um 13:26 hat Дмитрий Фролов geschrieben:
> Hello, Kevin.
> 
> This was just cleanup, based on the inspection.

Thanks for clarifying. I've updated the subject line to "vmdk: Clean up
bdrv_open_child() return value check" to avoid misunderstandings and
applied this to my block branch.

Kevin


