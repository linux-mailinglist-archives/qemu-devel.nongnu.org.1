Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E882A7FC
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNp78-00041L-2X; Thu, 11 Jan 2024 02:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNp75-00040v-Gt
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNp73-0003PE-WF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYaf3Oo4/8OWonRZl+2k9uoHqtgAxzBQMDg7FiWDVNQ=;
 b=hlToSRYNW1EmiEkYpr4I2qY1Lkeqn6rNbnj7vwmBg8F2PR5AuXuwR83HaJs8/xyoaJgjqA
 h6qZplLSYEcC8wPfYVs1Nwz6RJa0m1IFMrF9FHaq0edyIIAXM5eKBUitKPyT69ZKMwG0Bq
 C6tN5ZmsIuvyen6IMBPoyUuTjEWFzsY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-A6jaGvmSPXqY_mT5Ed8dYw-1; Thu, 11 Jan 2024 02:04:23 -0500
X-MC-Unique: A6jaGvmSPXqY_mT5Ed8dYw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28db680c0f7so402628a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956662; x=1705561462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYaf3Oo4/8OWonRZl+2k9uoHqtgAxzBQMDg7FiWDVNQ=;
 b=Z8Wnd0X+VGFC3Sjr3PvsaoRUSU+ssqNeyOrf4WGnS44TGWP9GKKF/keylIOJpiVrvJ
 bKlYQk1hD+7D+vgsoYGDmIsV/7y6MT8bdjGsL2z17HP5QfW1X0gld/FO3C19f81POyr/
 SkxiLRZCbv0ottSTRCH6hId8dsdCfG017tc4sL52CkDpO144jiyO0OzbOgN1TqG+4sqH
 JrtGv52w82nW2AoaB/N/fEqyDfNuKeRLjpyI1WFg0Uy2oyZ8RRmCKDtG3jzl8XnRZCym
 8+3d3KLd+G8jSDduxQ+rUyEIUS8NZV4aQkABEcMOb8oGuHqGXGbBO9v2qwj1xeYSrPhb
 eQYg==
X-Gm-Message-State: AOJu0YyC8ghBU7+n9e8NeCX4kTJ41ivyezQg3Cl5bS0f7flHWGmjVomc
 H8QXiHSeDbf4S2FD3YUx0ry1LOx4s4/9OgNO9pzsJPHo+tFaqf/AOm79X8YOY35rNKnvM/o2EUq
 LzVedDrLIrMAxpKzdgWmfkUg=
X-Received: by 2002:a17:90b:33c8:b0:286:4055:63e0 with SMTP id
 lk8-20020a17090b33c800b00286405563e0mr1380201pjb.0.1704956662615; 
 Wed, 10 Jan 2024 23:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElEilmnsZ51hg0ScQwXHREoL8YUMGbhqew7Lq8T7NzKaxaRwrxe5zN7K8y1XPRyr0Gvj8hcw==
X-Received: by 2002:a17:90b:33c8:b0:286:4055:63e0 with SMTP id
 lk8-20020a17090b33c800b00286405563e0mr1380187pjb.0.1704956662265; 
 Wed, 10 Jan 2024 23:04:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z18-20020a17090ab11200b0028ddf2efa58sm748077pjq.16.2024.01.10.23.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 23:04:21 -0800 (PST)
Date: Thu, 11 Jan 2024 15:04:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 03/30] io: implement io_pwritev/preadv for
 QIOChannelFile
Message-ID: <ZZ-S7st40VtguUyx@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:25:45PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> The upcoming 'fixed-ram' feature will require qemu to write data to
> (and restore from) specific offsets of the migration file.
> 
> Add a minimal implementation of pwritev/preadv and expose them via the
> io_pwritev and io_preadv interfaces.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


