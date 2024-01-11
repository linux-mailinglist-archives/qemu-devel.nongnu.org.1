Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386C82A94D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:45:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqg9-0003bG-VB; Thu, 11 Jan 2024 03:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNqg7-0003at-NC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNqg5-0003I4-GX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704962680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abTHeD6zSHYLyaVH3x7LvKSVsV8UTKn7wz8SXXvcRaU=;
 b=H0deFgVVzZwkwdn/PNQwhyMh4CeYTabZzIRF2Q3HCgBfVXTIgm9H0fl7u8nWte+oEFKWoM
 XtbBAgkgMhrnAfqEnBd5PloX32K91jd4LV2JZ/A+oJhiXLHi7ye5/a9RKSMzr9BOe/wRZI
 WDluYONqOa3eZ/Wr3ySs6Um3KKZnzqo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-VPSpYW5FMr2Xy6hhgR7oDA-1; Thu, 11 Jan 2024 03:44:39 -0500
X-MC-Unique: VPSpYW5FMr2Xy6hhgR7oDA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so1468336b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704962678; x=1705567478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abTHeD6zSHYLyaVH3x7LvKSVsV8UTKn7wz8SXXvcRaU=;
 b=Daj/5T5wFz6q4FG8CD0Op4Qve5MAD9NF931IG9TXXLWweG2OmFFpZbH5iV5sJHn/Ie
 pKRujegWSOsbCJIUYIH2/NOnGlaGPR+ptugBaAZE2soNkxV8kqehlHhgsiD7b7xlEgSS
 S0e8NImDgW4sByuLu39qdaxIkMgRvDkjitpTC3VtOAaf8T8Q6UVtBD7slaMPtMY+iShP
 cprjDsQWsNjrUfFUZ15WUxdHeYKH6CpowxZMNVn7cUzzhu9eX6etQ+flJf4PR0kT26kw
 YH6Ubi7xMnhnbaMXP0H3+yulaW4y9qHq8spGgzJtNNeulYab9l41yd7FJlh6X8LL4XUr
 brTA==
X-Gm-Message-State: AOJu0YwjVClO48NRmmtpKEJS/XGe69Ql8laXphhPDhFVZ8HtOTnNPmcw
 Vfk3YZ90C/idJyuJem2yh34PXoIVeq0bvVCjaKJqNiuPQGvJtLxNcQVsiFrU3X9zUuH44pBOwz9
 WMI9o9ER7s+MVQzza1tSUtQZBcC4TnsXJzA==
X-Received: by 2002:a05:6a00:3cc3:b0:6d7:e74b:a517 with SMTP id
 ln3-20020a056a003cc300b006d7e74ba517mr1912221pfb.3.1704962678271; 
 Thu, 11 Jan 2024 00:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyJrtVamSocV5dJy0EY5rB7Si5X/HDrBJf0QH6SBsdXZkz4PNq9n5RM5rUovNO2S+vvJgeXg==
X-Received: by 2002:a05:6a00:3cc3:b0:6d7:e74b:a517 with SMTP id
 ln3-20020a056a003cc300b006d7e74ba517mr1912211pfb.3.1704962677923; 
 Thu, 11 Jan 2024 00:44:37 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa78817000000b006d095553f2asm631236pfo.81.2024.01.11.00.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 00:44:37 -0800 (PST)
Date: Thu, 11 Jan 2024 16:44:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZZ-qbom2UqEX0uS7@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Mon, Nov 27, 2023 at 05:25:46PM -0300, Fabiano Rosas wrote:
> Make sure the data is flushed to disk before closing file
> channels. This will ensure data is on disk at the end of a migration
> to file.

Looks reasonable, but just two (possibly naive) questions:

(1) Does this apply to all io channel users, or only migration?

(2) Why metadata doesn't matter (v.s. fsync(), when CONFIG_FDATASYNC=y)?

Thanks,

-- 
Peter Xu


