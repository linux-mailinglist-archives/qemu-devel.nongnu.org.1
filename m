Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4F730441
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9SpT-0000sx-3s; Wed, 14 Jun 2023 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9SpR-0000sS-8i
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9SpP-0003GD-Pf
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686758074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DShtWlBtoeIl+4FNeWgqt8PuoyluMLn+sVQfn99eNEQ=;
 b=DgIViIutNSdsynmxEHH8RuRvKQwligoR2fdtBnOLyf4SLmFyampunjJA2XvVGJjC+b0pcx
 8IeN+77HLCotBhYGzlXZUJjny04lhm7jgm7l5DBfj18JU2QEqKrUaBGTrP/sB9ZLaX6vIr
 BgZtKulmMwfJ/mL6ZpjP8/+LG8fYNMc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-FekcAkSXN7uQpw_Q-2_BDQ-1; Wed, 14 Jun 2023 11:54:32 -0400
X-MC-Unique: FekcAkSXN7uQpw_Q-2_BDQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f9eb7d5202so6425921cf.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686758072; x=1689350072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DShtWlBtoeIl+4FNeWgqt8PuoyluMLn+sVQfn99eNEQ=;
 b=PVr+K7kG+yShBC0osa5/HBm8E0caH7ocf4WtEqDLk2Jr7FNUC3bbIWHVxN8DT3Fy+j
 aBQIgCSPjY6xrzxxtKJRDOoqr0SVwric10o/aPaI0Kdb4X8PBRQP9bEfFe7WFwsU89aO
 uoKQ0mr+l8GEJG+B08XLCrv0b7eEArHJUe2BYfAJNVH+DxCmvs8WTj5pkj8pXHCsvaFf
 alc7ROYePrV29YRVRY10h02tOWr3qMplSiNuCpvWAA+L7zfPYYhpe2R7euFwyJVGn6DM
 DJyZ6NEFjUmV1xHivR2hwoTqtbD9uxnth+ZKwbjKglLOZHvtTD8BKDglos5nHgCUk36r
 nqiw==
X-Gm-Message-State: AC+VfDzQ+M+lVEUGCQWw27u8HKNot8nyanVDBTA9AzgOvEEWbv/1lf5I
 F7vHCGn9QHiVz05rVGQ0Jq74RvaQaKOVFjk4MtjU4TlmuddUbAKR++PDtOx8+vva/49YCMOzfYM
 QECdNZ7eKAxHGGUU=
X-Received: by 2002:ac8:5846:0:b0:3f6:b465:8ccc with SMTP id
 h6-20020ac85846000000b003f6b4658cccmr19338701qth.1.1686758072471; 
 Wed, 14 Jun 2023 08:54:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55RAR1EgyXzct4YYqsKUjqDr1Z8d0VYds46ezsknTyEhJAS9zIAx5VyXDGw6IANcNu1rORdQ==
X-Received: by 2002:ac8:5846:0:b0:3f6:b465:8ccc with SMTP id
 h6-20020ac85846000000b003f6b4658cccmr19338685qth.1.1686758072230; 
 Wed, 14 Jun 2023 08:54:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h27-20020ac8777b000000b003f6f83de87esm5096005qtu.92.2023.06.14.08.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:54:31 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:54:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 19/20] qemu-file: Simplify qemu_file_shutdown()
Message-ID: <ZInitusi7EApwD2t@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-20-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-20-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 30, 2023 at 08:39:40PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


