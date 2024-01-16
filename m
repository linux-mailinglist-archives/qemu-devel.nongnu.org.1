Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDE82E9F6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:24:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdn5-0003qi-SD; Tue, 16 Jan 2024 02:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdn1-0003qX-PY
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdmz-0002NV-E7
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705389792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RxN/vm1WzBvo7vrGqFknmLy0ZfOeHa9LKmfi8puRVI=;
 b=YlvraPmvkSZ+wgkNoUDE6y6JBM1Fl8an52GLIBIitXPFubl2+asny2LN8dcb6Rlsef22Ru
 XIRAwby55AiJBCO3NK9YiqMwQLIyhQIE+5DIijfg4B4Milu3HE5OHVCgYgBJ6YhtyuqMD0
 saHmU0TgO7YgMQ3LPlngcawfamf4rmk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-uA69zwZ8MXiblMxQiuQwFg-1; Tue, 16 Jan 2024 02:23:11 -0500
X-MC-Unique: uA69zwZ8MXiblMxQiuQwFg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ca4e0122f6so195845a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 23:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705389790; x=1705994590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RxN/vm1WzBvo7vrGqFknmLy0ZfOeHa9LKmfi8puRVI=;
 b=hfldB/rJv561R5W6V+AXJsSvXNfhfkWY6dTGfpzttZcgaTtK1Go3Xsfmp5qJeW+AdX
 0VZKUn+Mm7VOxLysGKEqq9kcHnjYriE1XLD25QM5V5rEgzKx/nQRDt1DM2B2zEe22fCJ
 GtXqlSsYzwEqTSkW+n6DSwjidpSIjimn89eIiTdtWuHI2Qu6/r0KQMd4+NyqONyuZiFD
 1HvHrh9XCUhGjDBOQ5KCEkWuZ6RH5UXbJRdVI8veNVytuiR8h2S5ZZOchGYC5O/p3YNM
 QX0YeDwyKU+0taE/MSy6N6TamvMPvq8wsLI3Y/kjn1+vqnH2w8qQEzmDUybZ96XuS5Zc
 hzLA==
X-Gm-Message-State: AOJu0YxGeNOFP9yilpI1VUeKDr68XddVxCHO1Lz51Iudktl/mCrLgPvV
 UL85+9QvcX8VKgftw2p1Q6m1mA8HVz35QDTL3HCKO5fwbLr41EEaveGSs+z1oXNx9KV2+rcCedn
 Dflr2PpWXmNl0H8KxEHyCJd0=
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id
 wl34-20020a056a216da200b0019a49c8b9e6mr14402800pzb.0.1705389790138; 
 Mon, 15 Jan 2024 23:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlymuImsOAOpac/CqG1JOEqbwoXAsPJa4e8kImzJFGvMRqcKjXmJmYUjKWAfwPtE7ay00i5w==
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id
 wl34-20020a056a216da200b0019a49c8b9e6mr14402790pzb.0.1705389789894; 
 Mon, 15 Jan 2024 23:23:09 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v11-20020aa7850b000000b006da1d9f4adcsm8636703pfn.127.2024.01.15.23.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 23:23:09 -0800 (PST)
Date: Tue, 16 Jan 2024 15:23:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 17/30] migration/multifd: Decouple recv method
 from pages
Message-ID: <ZaYu1qrthidQ-Pxv@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 05:25:59PM -0300, Fabiano Rosas wrote:
> Next patch will abstract the type of data being received by the
> channels, so do some cleanup now to remove references to pages and
> dependency on 'normal_num'.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


