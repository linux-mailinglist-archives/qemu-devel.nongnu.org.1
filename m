Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE727B2CAD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7Qw-0007eE-KP; Fri, 29 Sep 2023 02:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Qt-0007dy-A2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Qq-0003zX-GD
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695970619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZ/yRrzaP4gTVk96dYGHsIlnqGE9tojicKVj5c1ZD4A=;
 b=f89XlDNGd2yD9zJYIPu5u+NHXFzu43bIzm/cRyVD/LhzvvUq3y6Es57dqZwivf+9V3YiNC
 ae0HU0AaRjnizkiTbKSUHdfZFXxmxtsYfOLH6Cpt1w2FzCnDlvaC1Y8PlN1lBqnsfRhc8D
 deC/n/sD4A/tbUfvpxLuD2MrwPP/kLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-G9dryhfIOEWKCLrU-iw8nw-1; Fri, 29 Sep 2023 02:56:52 -0400
X-MC-Unique: G9dryhfIOEWKCLrU-iw8nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C163811E86;
 Fri, 29 Sep 2023 06:56:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7F3D40C2064;
 Fri, 29 Sep 2023 06:56:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B44A821E6904; Fri, 29 Sep 2023 08:56:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>,  david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  bmeng.cn@gmail.com,
 alistair.francis@wdc.com,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 palmer@dabbelt.com,  liweiwei@iscas.ac.cn,  Bin Meng
 <bin.meng@windriver.com>
Subject: Re: [PATCH 0/4] RISC-V: Work towards enabling -Wshadow=local
References: <20230925043023.71448-1-alistair.francis@wdc.com>
 <2cefc804-1b7b-614c-7c96-3004609878ea@ventanamicro.com>
Date: Fri, 29 Sep 2023 08:56:50 +0200
In-Reply-To: <2cefc804-1b7b-614c-7c96-3004609878ea@ventanamicro.com> (Daniel
 Henrique Barboza's message of "Mon, 25 Sep 2023 06:11:01 -0300")
Message-ID: <87pm21h3gt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> CCing Markus since he might want to add these in his shadow-next tree.

Queued, thanks!


