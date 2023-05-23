Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36370D2FA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 06:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1K1W-00066S-IV; Tue, 23 May 2023 00:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1q1K1T-00066E-UC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 00:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1q1K1R-0005Ce-HN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 00:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684817599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdQ/HO2Ol3QXP/3l+Yriu13rdBrJuoLgg78Nv2NewaM=;
 b=gRyHBVLY5YQTPrHwe9MTAdhsKOADyphh82t9/Cn7nOWGfnzYtjfaYTAtK2m5oX7HxKFTtr
 rZOaYIxjF4ELJG+aLAhHC+U30HohGX5q6H2ir0smOkN4xaw+mcTXGspCDKfj81hUfYT285
 2rvMIC5GRTWi4PCXmiQOO0o2GoCwwCI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-VYYkPtMaNnaNYUXReWfQaw-1; Tue, 23 May 2023 00:53:14 -0400
X-MC-Unique: VYYkPtMaNnaNYUXReWfQaw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69CA53C0C880;
 Tue, 23 May 2023 04:53:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CDF2492B00;
 Tue, 23 May 2023 04:53:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 085161800626; Tue, 23 May 2023 06:53:13 +0200 (CEST)
Date: Tue, 23 May 2023 06:53:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org,
 jacek.halon@gmail.com, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Message-ID: <l4gjfdxj6zu3rklfz6swbnhjaxpfca4bht33thxrwpoodx6feh@egbsmhcyb4gm>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

> >     -QEMUCursor *cursor_alloc(int width, int height)
> >     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
> >       {
> >           QEMUCursor *c;
> 
> Can't we check width/height > 0 && <= SOME_LIMIT_THAT_MAKES_SENSE?
> 
> Maybe a 16K * 16K cursor is future proof and safe enough.

Modern physical hardware typically uses 512x512 sprites (even if only a
fraction of that is actually needed and >90% are just transparent pixels).

take care,
  Gerd


