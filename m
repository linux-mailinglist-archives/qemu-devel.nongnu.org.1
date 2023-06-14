Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08273076D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 20:39:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9VNz-0004kB-Bd; Wed, 14 Jun 2023 14:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9VNw-0004je-Lm
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 14:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9VNu-0001Jr-Oj
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 14:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686767901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iadzoWOSts5hgGw0UIcjds1CyqJfRvc8Khp2/Ng4to4=;
 b=O3V/2vI7eh8jvw0pkyN2S1vV9TOYd/eEpCPezruDRRw/8x0sVWTf3G37eXRDOKPcrnl+Ld
 5GNhtPdj3rnW5rzGRT34Vd0PuyaWdkMChr76StSW1pzXAFN4QP6lEvigvwQggx09qeVlgG
 QSEDLUVEQg/U86VU4753vGWJbRk2+o0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-tvxnKvTTMXCPdIAzqkeMDg-1; Wed, 14 Jun 2023 14:38:18 -0400
X-MC-Unique: tvxnKvTTMXCPdIAzqkeMDg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75eb82ada06so158916485a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 11:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686767897; x=1689359897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iadzoWOSts5hgGw0UIcjds1CyqJfRvc8Khp2/Ng4to4=;
 b=cUhi/kku6RIvp6mwwAphoAuZV4lvPn3uODmBO4nw/2SXpmH3cBH+tEMW0ZfiwV7iFG
 8wLjA3TovxTQlmxUsyKzoU1vVcs74rc99rheZI1kqoEc8ZkbwD7ObWXJXRLBRPHrHLSy
 f02w7gN/qI9tA9tLoLAQkCSoSzu6q1hbK9YOKV/b+2YRDN3g+Y6LRsFKbCH0zas6JJXd
 Uxdq/C+F2t1Y/ShAfiJ+z1FdsMLqjzV7SgutqBDan0aQ+dnL9f5K7NJtc000nsnIqvOO
 5kIcX0EpZVtfiNHTcbbuEnG+IY8hHHUv4D6WHxi6ujUcFXy17JymyXpGXAFHewv8d10D
 9TxQ==
X-Gm-Message-State: AC+VfDwu8TiWkVjUBQ6GprWx8rgJWearSvnH9OhahlHngXlgVw+gtPxj
 /nLOBSlaiMZlUTj/Cx7MwEhYpjNV/21fiRi0ewVAeBdgLibDnEijcNgZHxRP7Ex97O5Xcxr5XoN
 29iXALVMiRJsKF8E=
X-Received: by 2002:a05:620a:2541:b0:75b:23a1:69e2 with SMTP id
 s1-20020a05620a254100b0075b23a169e2mr18726266qko.2.1686767896778; 
 Wed, 14 Jun 2023 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gGbqg8bPGMY1amxX0K6df14vxll2fiG9eENkOKBh4/wpkxHXhmWQhc10eJmh55UmmDVoB3w==
X-Received: by 2002:a05:620a:2541:b0:75b:23a1:69e2 with SMTP id
 s1-20020a05620a254100b0075b23a169e2mr18726260qko.2.1686767896529; 
 Wed, 14 Jun 2023 11:38:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w20-20020a05620a129400b007620a2f6f0dsm467738qki.54.2023.06.14.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 11:38:15 -0700 (PDT)
Date: Wed, 14 Jun 2023 14:38:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZIoJFoBlkS5WFOyZ@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n>
 <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de>
 <ZInhvxq9YgoM9ykZ@x1n> <874jn9vs9x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jn9vs9x.fsf@suse.de>
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

On Wed, Jun 14, 2023 at 02:59:54PM -0300, Fabiano Rosas wrote:
> In this message Daniel mentions virDomainSnapshotXXX which would benefit
> from using the same "file" migration, but being done live:
> 
> https://lore.kernel.org/r/ZD7MRGQ+4QsDBtKR@redhat.com
> 
> And from your response here:
>  https://lore.kernel.org/r/ZEA759BSs75ldW6Y@x1n
> 
> I had understood that having a new SUSPEND cap to decide whether to do
> it live or non-live would be enough to cover all use-cases.

Oh, I probably lost some of the contexts there, sorry about that - so it's
about not being able to live snapshot on !LINUX worlds properly, am I
right?

In the ideal world where we can always synchronously tracking guest pages
(like what we do with userfaultfd wr-protections on modern Linux), the
!SUSPEND case should always be covered by CAP_BACKGROUND_SNAPSHOT already
in a more performant way.  IOW, !SUSPEND seems to be not useful to Linux,
because whenever we want to set !SUSPEND we should just use BG_SNAPSHOT.

But I think indeed the live snapshot support is not good enough. Even on
Linux, it lacks different memory type supports, multi-process support, and
also no-go on very old kernels.  So I assume the fallback makes sense, and
then we can't always rely on that.

Then I agree we can keep "file:" the same as others like proposed here, but
I'd like to double check with all of us so we're on the same page..  And
maybe we should mention some discussions into commit message or comments
where proper in the code, so we can track what has happened easier.

Thanks,

-- 
Peter Xu


