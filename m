Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B324282E323
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:02:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVy0-0003gI-BJ; Mon, 15 Jan 2024 18:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPVxv-0003gA-Kj
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPVxt-0005Ns-UF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705359716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lWzglqg1NiGwXmbEE822WXmG3AfzDIyVntAzA4ufGjQ=;
 b=gSFovc/CRK6naMPUf0+DnaAIP25vhm5vJ+Q9Zb6SS4gJp2SZskGfKbcbQLOsNQ89KQaprF
 dT6s08kusBJk5xG2plLUPsUx7DLOKTPTXORWuOn0Q9uAkKQREBe6PwwsSh1Xz44Qh3TzTX
 bENWfkQAY42kvrVTewr1URh2fK8iBi0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-TVQqa_x1NSG36c8xBsNfyA-1; Mon, 15 Jan 2024 18:01:55 -0500
X-MC-Unique: TVQqa_x1NSG36c8xBsNfyA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d40e8aff1eso19157705ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705359714; x=1705964514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWzglqg1NiGwXmbEE822WXmG3AfzDIyVntAzA4ufGjQ=;
 b=KKuYGVUfYBLhRAZhR31OP6uHi+ycHN2tIvDCn80QOD9X5WID7Qr6OYeBODDFYGhwT1
 v2+Bw2wQvg3F9swfKEXYysIhatTEho7312AfSCflqYrvQCTaEbKcmxBjgldNmWe5OzT7
 lhqRcawtF0a/CycOL2Mo3LMihz0y7SLqluY+tgxWiVgEqKmZb0QBCuYsVSdUGRa7GPv+
 cYl3X0GEoaNrwpq08fAgdAfgZtPzLc8vzxnSs9KZy/Fzo7afJ4tuGKW1SOiOPW2XhRqg
 +KullPXv7WmVVum7EVL1rv39sUyoOo29pgJdr9L6MuI/jpilPdNT2y5OUj0NwtAfJ7JA
 FPxA==
X-Gm-Message-State: AOJu0YyNBikrmKZdis04wg1SywG6ajC8Az4Cu3Ob+pgKA+QFyUgdrLHh
 ql/CtBwPiIOcn7vjXG1cpqx5LSG/hQHuT4cg6cU4frfXgYmCWHzEYeIvDS5zhk3pt4khQFQ1Dv/
 pOkR3oBe5Ifkz/OM25Ztgyjc=
X-Received: by 2002:a17:903:120f:b0:1d4:e2bc:89f3 with SMTP id
 l15-20020a170903120f00b001d4e2bc89f3mr13726858plh.4.1705359714370; 
 Mon, 15 Jan 2024 15:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm4Ieva8RvmnJNGj99rKznuiiBPf8lpiyIpn0Zei1FVpGQ7VhHdTIWnMbb7Xg1zuGiQXqF/A==
X-Received: by 2002:a17:903:120f:b0:1d4:e2bc:89f3 with SMTP id
 l15-20020a170903120f00b001d4e2bc89f3mr13726834plh.4.1705359714048; 
 Mon, 15 Jan 2024 15:01:54 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w2-20020a170902e88200b001d40ca98b9esm8037628plg.65.2024.01.15.15.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 15:01:53 -0800 (PST)
Date: Tue, 16 Jan 2024 07:01:45 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 11/30] migration/multifd: Allow multifd without
 packets
Message-ID: <ZaW5WUXrXY9e0kDl@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-12-farosas@suse.de> <ZaUcKy41AsAdqT0G@x1n>
 <8734uy5tlq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734uy5tlq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 03:39:29PM -0300, Fabiano Rosas wrote:
> > Maybe multifd_use_packets()?  Dropping the migrate_ prefix as this is not a
> > global API but multifd-only.  Then if multifd_packets() reads too weird and
> > unclear, "add" makes it clear.
> 
> We removed all the instances of migrate_use_* from the migration code
> recently. Not sure we should introduce them back, it seems like a step
> back.
> 
> We're setting 'use_packets = migrate_multifd_packets()' in most places,
> so I guess 'use_packets = multifd_packets()' wouldn't be too bad.

I actually prefers keep using "_use_" all over the places because it's
clearer to me. :) While I don't see much benefit saving three chars.  Try
"git grep _use_ | wc -l" in both QEMU / Linux, then we'll see that reports
275 / 4680 corrrespondingly.

But yeah that's trivial, multifd_packets() is still okay.

-- 
Peter Xu


