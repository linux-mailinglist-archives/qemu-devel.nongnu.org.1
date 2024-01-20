Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A25833275
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 03:37:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR1E4-0007bN-IR; Fri, 19 Jan 2024 21:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rR1Dw-0007Yg-9o
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 21:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rR1Du-0000Q6-RM
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 21:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705718201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qAt92TD7r/kV33JB8p61Idtq79W16hYL2FpKLKTZ8OE=;
 b=D8q6ARvHHzLMfl9YysY8Qtq9tMQKaGrVcIB6yiCYO8grqKMSrEMQRbtNE9N3HPBelZ9IsZ
 1+aQc4TgBHUR1zY5Q0ELKHrAnBOssBcgp7WzolnDJug+5IYIEfinQgr//Ya5wZ7JDHESKZ
 CYuGz6cUuFDZ8Sa/VfZHVXDER7mRLjA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-Xmbc17GLO9GFSFO9P1lPPg-1; Fri, 19 Jan 2024 21:36:39 -0500
X-MC-Unique: Xmbc17GLO9GFSFO9P1lPPg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso509183b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 18:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705718198; x=1706322998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAt92TD7r/kV33JB8p61Idtq79W16hYL2FpKLKTZ8OE=;
 b=eB8xpT1PEiijNG8gSOpcChTPteN7u137uB2hG8fDqDC6IG/YvoaJ2bhUQniDSZiKzA
 v4M+6DGcwelSf1w4YH8mzBYVL1CKjUhs7/vU5hFAvVFw110rI6QwRtpagiJIReREHAXg
 UVv6kZOX2jTNWEj+8IXyKlRzT4Ly15vPglm5Iwwlurhc+zeLvAp2CNyrtHlTn9hjE7Bi
 JSZ4CHYmV/Z9qYhlFe22IavkD1IjSOXGZMFSwPbPyZRkaRVaV4kKHkVJ/HEoyY4xjbEn
 TQaE30CmBWyB4a7kcIrfGhVQM6qWDcGixmn17rTHJiBlouNUDphRDs7VngBL2oQOfVqM
 orpA==
X-Gm-Message-State: AOJu0YziwFFd1iMVXmLHbvwH5vIRVxkC1Sxq5BD4Rr8o5S9iLYUc5kzj
 XRAlg+1vqZcJmHdTKBUBN7xhUxkOSkczh14f1T4tVPAls9XTqWocq4TRXoD3oUAhThCKEqVWUiN
 KLqNR9ZnRSurdDakLi2zzdI9qM/cHSlq0waGjR+vWOYwDEXZoVn0JcyOIm4tAArz/83Sa7mFu9a
 JkkzKgkYTjyOB1Zg5YYYiWCZrjnUWLBpHfsYBW
X-Received: by 2002:a05:6a20:438d:b0:19a:e152:656 with SMTP id
 i13-20020a056a20438d00b0019ae1520656mr1962805pzl.3.1705718198572; 
 Fri, 19 Jan 2024 18:36:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsjuWQG5w1q0jImV/uLGRDy7xcQ9Yiz6zrFs5S5k0nZYa7MqhC8iy//yolfRtwFOhAAXgndQ==
X-Received: by 2002:a05:6a20:438d:b0:19a:e152:656 with SMTP id
 i13-20020a056a20438d00b0019ae1520656mr1962782pzl.3.1705718198208; 
 Fri, 19 Jan 2024 18:36:38 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qd13-20020a17090b3ccd00b00290689f5e10sm331387pjb.31.2024.01.19.18.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 18:36:37 -0800 (PST)
Date: Sat, 20 Jan 2024 10:36:34 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bandan Das <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH 0/3] migration: some small cleanups
Message-ID: <Zasxsn8rfHUlecHM@x1n>
References: <20240117075848.139045-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117075848.139045-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

On Wed, Jan 17, 2024 at 03:58:45PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> I found three tiny little patches lying around probably for a long time,
> sending it out before deleting the branch.  Review welcomed, thanks.
> 
> Peter Xu (3):
>   migration: Make threshold_size an uint64_t
>   migration: Drop unnecessary check in ram's pending_exact()
>   analyze-migration.py: Remove trick on parsing ramblocks
> 
>  migration/migration.h        |  2 +-
>  migration/ram.c              |  9 ++++-----
>  scripts/analyze-migration.py | 11 +++--------
>  3 files changed, 8 insertions(+), 14 deletions(-)

queued.

-- 
Peter Xu


