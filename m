Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD87823B89
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFUn-0007Vm-9A; Wed, 03 Jan 2024 23:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFUh-0007Uo-VJ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFUg-0007JP-Jx
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704343089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jq5+fyGtnpO9tHHchw5tDcaRkR5Kpm9JOtwIqWVjWRk=;
 b=PDeT6NzyzLyvQupALw7KNLU7e3rKVOFosGcKnIDHx0sEaLZ78bNQUUAKwRmi6raKzU4WPg
 XPPcWAPjIEkPbICH5TkA6Na2h9UCH+w/4J2+ixsZ4fiP1qN3oMrvIlsYcfymTAISF+tZ16
 DJ1A2OYk3J+P26OhccdictewczXP+Zk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-KQIAUm6KNz-2wOluGGL88A-1; Wed, 03 Jan 2024 23:38:08 -0500
X-MC-Unique: KQIAUm6KNz-2wOluGGL88A-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so29109b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 20:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704343087; x=1704947887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq5+fyGtnpO9tHHchw5tDcaRkR5Kpm9JOtwIqWVjWRk=;
 b=JSs6P7bCxVuFXweEkmVHGYma64ONf4bAAjuSHb4pK3AveMc+31MfuDb9hQGZgdKuVU
 RyTluJBQp8JT109Cq/Sx/Oej1eXotvUIvcF9SxK01TL0Mj74MLHvCgI1N5Io0Ey3tx0Y
 HC51S+hdZPunx68V94e0VwS7dWQu6jjz+eMD6KktQo6qLTKT7ArDmbYE5MJmSqN0g/U8
 NZd5SCMSxFxDJPTxVCVtdY6ckLv8UyBoMZUC/cnDFcrWyGwXveqtG5wwe7Lcg1mmk6qr
 MmEeGxeN2q4Z/acW16T1Ckilw2rnh2D1CmEA58pr+LMBOphR6WAgpBK1NljuzZtNDUyk
 toiQ==
X-Gm-Message-State: AOJu0YyVGERRmr3uNVQjtJCJdtdXCLtq4w51ykHYEavR31e3IZdWVVuw
 Qw7VwOmhMoTIgiFYkn9Z1PmSEfEYZEQLE7r2mdiOs2JDoVjxoxBC5T+R4cyDNLZUPsQ1twezFw2
 F2s+lvSBuKw/ngRJpHsmvi+4=
X-Received: by 2002:a17:902:9a85:b0:1d4:be1e:f197 with SMTP id
 w5-20020a1709029a8500b001d4be1ef197mr81829plp.1.1704343087763; 
 Wed, 03 Jan 2024 20:38:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsREsDzLz2CjcYymrcn2Qp1/O7JKm+FdafJkBtx2yAoQ6zbfhy10FvZZct6m7UjaENvytsUQ==
X-Received: by 2002:a17:902:9a85:b0:1d4:be1e:f197 with SMTP id
 w5-20020a1709029a8500b001d4be1ef197mr81818plp.1.1704343087449; 
 Wed, 03 Jan 2024 20:38:07 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 d9-20020a170902aa8900b001c407fac227sm24625667plr.41.2024.01.03.20.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 20:38:07 -0800 (PST)
Date: Thu, 4 Jan 2024 12:38:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/11] migration: Misc cleanups and fixes
Message-ID: <ZZY2KTOKKef48n11@x1n>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Sun, Dec 31, 2023 at 11:30:05AM +0200, Avihai Horon wrote:
> Hi,
> 
> This series contains misc cleanups and fixes in migration code that I
> noticed while going over the code.

queued.

-- 
Peter Xu


