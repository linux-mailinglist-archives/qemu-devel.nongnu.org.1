Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56173752C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBh92-0003Ue-99; Tue, 20 Jun 2023 15:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBh8u-0003Tz-Qf
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBh8q-00052w-C1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687289750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3teOPTqD/QpAWChY+neKZwUqLEUp64/PIHHc5ah/5go=;
 b=KjZhiNxI8GEeqoCjwDR/isQB13hjY7f8FfjvST/P9TFRBdVg+xy+4b/PkdOGCXEg2J1RAs
 FV67eGXfJmxwC7tCD1M4YJ/yPR5tG5UJKSMGlUf+KD7M22bhbhQfgP1BOR4ASEXWZ/f7R4
 SzA+kM1X4dugjP5u52fJ+Lu7/5mr9b4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-rfnbyehuMB-1JT-bW4FB0A-1; Tue, 20 Jun 2023 15:35:49 -0400
X-MC-Unique: rfnbyehuMB-1JT-bW4FB0A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-74faf5008bbso116341585a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 12:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687289748; x=1689881748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3teOPTqD/QpAWChY+neKZwUqLEUp64/PIHHc5ah/5go=;
 b=l0qvf3/2Efv6Px0ZeAgxlQwZppoVjkYSmuDkoyE79hjWBRl7JJvskMf9m010E2Bpga
 n22YmP8QzcOIKaco6jITYYzQAwEm736I0pw17LA9g5CII3PJc2KdyIiXRgsyUMlnmSpp
 Moq87F8jng883JVmNRjOBVnzxD/WM/UBzWSAibLWaSJFJL7OOU72XcLrvU2nc+O+LBBv
 BM+erXFuaLxah7zV7Hi9rID8fMH7YfV+F58R6u7vkhXdux/bBtGgfbn8siTRHDvv8Tpq
 BeeuEVHLYRtEhWMNezlP6M8xYd6My0dfYLgnWPEZ85KA6UU+b1/zb3bEXjIgtfCwWokt
 YkIw==
X-Gm-Message-State: AC+VfDyTbdQ74nLgnBsycoZZVVNLq/jDz0/gq8pfWNePLA4kQrknUrNi
 ZxJXZQWxHH4+Rc+js4LDsItdlOrgBBd63fT+TEMtoIPy8wfxpwt0SAYZ8QDsznndAJY1XlC5Pfd
 fnW4T2w8XxWPuggk=
X-Received: by 2002:a05:620a:46a2:b0:75e:ba30:8ccc with SMTP id
 bq34-20020a05620a46a200b0075eba308cccmr17037652qkb.1.1687289747660; 
 Tue, 20 Jun 2023 12:35:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61WZLvODRCTEAPlHxE7iufvoRVMGkGDNoeiavUhbWdJSbwYFac+mpc1YHnHClpsr5Zl+F1gA==
X-Received: by 2002:a05:620a:46a2:b0:75e:ba30:8ccc with SMTP id
 bq34-20020a05620a46a200b0075eba308cccmr17037630qkb.1.1687289747317; 
 Tue, 20 Jun 2023 12:35:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a031000b007606a26988dsm1425482qkm.73.2023.06.20.12.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 12:35:46 -0700 (PDT)
Date: Tue, 20 Jun 2023 15:35:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZJH/kfygyRaYWHom@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n>
 <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de>
 <ZInhvxq9YgoM9ykZ@x1n> <874jn9vs9x.fsf@suse.de>
 <ZIoJFoBlkS5WFOyZ@x1n> <87cz1wzsnf.fsf@suse.de>
 <5d158448-4c11-21b9-5e41-e7d57c1b2c7c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d158448-4c11-21b9-5e41-e7d57c1b2c7c@oracle.com>
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

On Tue, Jun 20, 2023 at 02:36:58PM -0400, Steven Sistare wrote:
> On 6/15/2023 10:50 AM, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> >> On Wed, Jun 14, 2023 at 02:59:54PM -0300, Fabiano Rosas wrote:
> >>> In this message Daniel mentions virDomainSnapshotXXX which would benefit
> >>> from using the same "file" migration, but being done live:
> >>>
> >>> https://lore.kernel.org/r/ZD7MRGQ+4QsDBtKR@redhat.com
> >>>
> >>> And from your response here:
> >>>  https://lore.kernel.org/r/ZEA759BSs75ldW6Y@x1n
> >>>
> >>> I had understood that having a new SUSPEND cap to decide whether to do
> >>> it live or non-live would be enough to cover all use-cases.
> >>
> >> Oh, I probably lost some of the contexts there, sorry about that - so it's
> >> about not being able to live snapshot on !LINUX worlds properly, am I
> >> right?
> >>
> > 
> > Right, so that gives us for now a reasonable use-case for keeping live
> > migration behavior possible with "file:".
> > 
> >> In the ideal world where we can always synchronously tracking guest pages
> >> (like what we do with userfaultfd wr-protections on modern Linux), the
> >> !SUSPEND case should always be covered by CAP_BACKGROUND_SNAPSHOT already
> >> in a more performant way.  IOW, !SUSPEND seems to be not useful to Linux,
> >> because whenever we want to set !SUSPEND we should just use BG_SNAPSHOT.
> >>
> > 
> > I agree.
> > 
> >> But I think indeed the live snapshot support is not good enough. Even on
> >> Linux, it lacks different memory type supports, multi-process support, and
> >> also no-go on very old kernels.  So I assume the fallback makes sense, and
> >> then we can't always rely on that.
> >>
> >> Then I agree we can keep "file:" the same as others like proposed here, but
> >> I'd like to double check with all of us so we're on the same page..
> > 
> > +1
> > 
> >> And maybe we should mention some discussions into commit message or
> >> comments where proper in the code, so we can track what has happened
> >> easier.
> >>
> > 
> > I'll add some words where appropriate in my series as well. A v2 is
> > already overdue with all the refactorings that have happened in the
> > migration code.
> 
> Peter, should one of us proceed to submit the file URI as a stand-alone patch, 
> since we both need it, and it has some value on its own? 
> 
> My version adds a watch on the incoming channel so we do not block monitor commands. 
> It also adds tracepoints like the other URI's.
> 
> Fabiano's version adds a nice unit test.  
> 
> Maybe we should submit a small series with both.

I fully agree.  I didn't check the details, but if we know the shared bits
it'll be great if we arrange it before-hand, and then it might also be the
best too for all sides.  Thanks for raising this.

-- 
Peter Xu


