Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEF7923F6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdY4J-0007SZ-3q; Tue, 05 Sep 2023 11:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdY4H-0007SI-DT
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdY4F-0004gL-6A
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693928054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M9m7UYptbbg8N3wv4g+d+tm4vsY+WKNLreXD8ge83GQ=;
 b=AGHtKB07h/7wd/YJrEEDnRg22jvw0QliLz3nZxkAMGcdQTRBVKjLVr4sMtWE/jHWIQbHxI
 1198A+ynMY1YszboFQsaPySivgNCfGhtBdGWp8pa5+nNE0AkFeAp/eNu/WRoLsK1T5UhtM
 pKCKwro5hKK+bFTxjMUmXp2RDqI5UUo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-_g4FxZFJPr6B0j4YSj82iA-1; Tue, 05 Sep 2023 11:34:12 -0400
X-MC-Unique: _g4FxZFJPr6B0j4YSj82iA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso8974711cf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693928052; x=1694532852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9m7UYptbbg8N3wv4g+d+tm4vsY+WKNLreXD8ge83GQ=;
 b=HqimNz5pjNhxeKiP5PIWY6ZuEbz3fA4kse7fSCL7+AM7ghO8WX0qhI0SmaSxrMfPfi
 KL+XK97D5T6UIDjwjP1+48h7FEwgm40wwXEELov0X8VLN5aQGRg6Mp/ji5kfauGV6Vmx
 x09ZEFT+MpOFBFNgEzZ6GFicV+GDQFAUnIxGF5Arcr4TgupC1fliSoWOcgcK2BT/V4Se
 Z9yNKVjR2dUEsn9uqgASmgrDCEvfVdRe1gHFEmE03k2hBu+DIn1lHIy/j8oa2Mc0FfA7
 LfGzU3ddF+Lfa428NwbBmCnOV9AwUxu9CC+zGx4HXiwqNCIYROX3vxIWhrUtZuxxeJbr
 bZUg==
X-Gm-Message-State: AOJu0YxUVpslcfiadddixpPDdZ6DaGA9VO0nVkfRgAjTBLDe4/McYFnu
 XkNguDotgFPE5p13dqqIMkhFSCmQE8JlGYEo1Dg8ReZKvRYEROuM3nONuIy/apsqIzzJWw6eua2
 AflwJ82eHHYmTsNg0lhJVNmo=
X-Received: by 2002:a05:6214:1249:b0:626:2305:6073 with SMTP id
 r9-20020a056214124900b0062623056073mr15167723qvv.4.1693928051744; 
 Tue, 05 Sep 2023 08:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdwtbkCSwGTj1cOXShKnspyOaPV9mqNQFS4kZDeefLFsur5Bk/dpBpnr2hjlXpqTptAUmrGQ==
X-Received: by 2002:a05:6214:1249:b0:626:2305:6073 with SMTP id
 r9-20020a056214124900b0062623056073mr15167708qvv.4.1693928051412; 
 Tue, 05 Sep 2023 08:34:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n8-20020a0ce548000000b00647120d0085sm4541532qvm.69.2023.09.05.08.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:34:11 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:34:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v5 8/8] migration: Add a wrapper to cleanup migration files
Message-ID: <ZPdKcfjGEfFKU6gV@x1n>
References: <20230831183916.13203-1-farosas@suse.de>
 <20230831183916.13203-9-farosas@suse.de> <ZPILtYXBVVCKDlWX@x1n>
 <878r9pagrk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r9pagrk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 01, 2023 at 03:29:51PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 31, 2023 at 03:39:16PM -0300, Fabiano Rosas wrote:
> >> @@ -1166,16 +1183,9 @@ static void migrate_fd_cleanup(MigrationState *s)
> >>          qemu_mutex_lock_iothread();
> >>  
> >>          multifd_save_cleanup();
> >> -        qemu_mutex_lock(&s->qemu_file_lock);
> >> -        tmp = s->to_dst_file;
> >> -        s->to_dst_file = NULL;
> >> -        qemu_mutex_unlock(&s->qemu_file_lock);
> >> -        /*
> >> -         * Close the file handle without the lock to make sure the
> >> -         * critical section won't block for long.
> >> -         */
> >> -        migration_ioc_unregister_yank_from_file(tmp);
> >> -        qemu_fclose(tmp);
> >> +
> >> +        migration_ioc_unregister_yank_from_file(s->to_dst_file);
> >
> > I think you suggested that we should always take the file lock when
> > operating on them, so this is slightly going backwards to not hold any lock
> > when doing it. But doing so in migrate_fd_cleanup() is probably fine (as it
> > serializes with bql on all the rest qmp commands, neither should migration
> > thread exist at this point).  Your call; it's still much cleaner.
> 
> I think I was mistaken. We need the lock on the thread that clears the
> pointer so that we can safely dereference it on another thread under the
> lock.
> 
> Here we're accessing it from the same thread that later does the
> clearing. So that's a slightly different problem.

But this is not the only place to clear it, so you still need to justify
why the other call sites (e.g., postcopy_pause() won't happen in parallel
with this call site.

The good thing about your proposal (of always taking that lock) is we avoid
those justifications, as you said before. :)

Thanks,

-- 
Peter Xu


