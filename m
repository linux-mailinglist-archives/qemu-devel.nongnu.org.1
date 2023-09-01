Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09179007B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 18:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6eG-0001yY-4m; Fri, 01 Sep 2023 12:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6e6-0001pb-Iw
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 12:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6e4-00026A-Cc
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 12:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693584314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHW44OcZRYTGT3H98LkzTMYRWEVY8+EuXnd3fmKMf8c=;
 b=Dzuvt9ZAe19GXC231sOk+5GMHKf/xz/xg7uEsC9CkJcFJL0aT7PG1NJEFX1ZMd+ncU/4B/
 cf8Dh6zG2ObAH3pjmQryNtbc6ovIi1OcYei7UNMRYcjCe5ajTy8eMyGfJLFV3yEO4DQylT
 RChs3XZgJBNwXcTz1gYMvpyzeKn8wbM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-imxU2QmfMo6atDDaO28iJw-1; Fri, 01 Sep 2023 12:05:12 -0400
X-MC-Unique: imxU2QmfMo6atDDaO28iJw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-64726969c8bso3512236d6.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693584312; x=1694189112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHW44OcZRYTGT3H98LkzTMYRWEVY8+EuXnd3fmKMf8c=;
 b=lA/qKGWR50Dd4E1Dpw/otYuzViB/6C/yGpabih27p8PGa/BaYNwoRLL0jlNxiq3aUf
 Mk/JereyvNNxVzpV73ERiZDdJVACuI9idVyzik26cLanVuXexj9SRjJ7FUxfg+kuLtKO
 9B6l9mIx6Usc2dTfrx11wQKzme7zhMnxfycyLHr1zRaQ2Jf37kJIEew099WMPzZKkmKM
 1zDgg/EoamsFPTlLbLhkOX8s86VsjQZhTYCbNCd9mq/aZ3MqAu6W8d1jx9FD5lw3iJCp
 aalpGxDbNK6ujG5MJUdJ9ewuvlfZhnBB3pbkie8ZQzsO8UHJ76JzVXxylVg1V9I3FBM4
 mgmA==
X-Gm-Message-State: AOJu0YwzwAx69/Y75ObGq42JdaswUopsy5NBD2narsvxdHcHNqRSd7j9
 M402idYnUqC7L1zX9AXmaFqwpcrtC0e5AYEGvj+sSGFtn61ckxnZipA6yVm2Xb8AljcRyOItqG/
 Zr2/twA/VwzxQimU=
X-Received: by 2002:a0c:eda4:0:b0:653:576d:1e4 with SMTP id
 h4-20020a0ceda4000000b00653576d01e4mr2786571qvr.1.1693584312349; 
 Fri, 01 Sep 2023 09:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKIZfoay0fwr5GUEhrp9DbjbgR5kYff/dh7CCj7KThtfepJaBoNpGUTBL1pNraA6I/a7Hd1Q==
X-Received: by 2002:a0c:eda4:0:b0:653:576d:1e4 with SMTP id
 h4-20020a0ceda4000000b00653576d01e4mr2786551qvr.1.1693584312079; 
 Fri, 01 Sep 2023 09:05:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d15-20020a0cb2cf000000b0064f713574dcsm1524624qvf.67.2023.09.01.09.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 09:05:11 -0700 (PDT)
Date: Fri, 1 Sep 2023 12:05:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v5 8/8] migration: Add a wrapper to cleanup migration files
Message-ID: <ZPILtYXBVVCKDlWX@x1n>
References: <20230831183916.13203-1-farosas@suse.de>
 <20230831183916.13203-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831183916.13203-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 31, 2023 at 03:39:16PM -0300, Fabiano Rosas wrote:
> @@ -1166,16 +1183,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>          qemu_mutex_lock_iothread();
>  
>          multifd_save_cleanup();
> -        qemu_mutex_lock(&s->qemu_file_lock);
> -        tmp = s->to_dst_file;
> -        s->to_dst_file = NULL;
> -        qemu_mutex_unlock(&s->qemu_file_lock);
> -        /*
> -         * Close the file handle without the lock to make sure the
> -         * critical section won't block for long.
> -         */
> -        migration_ioc_unregister_yank_from_file(tmp);
> -        qemu_fclose(tmp);
> +
> +        migration_ioc_unregister_yank_from_file(s->to_dst_file);

I think you suggested that we should always take the file lock when
operating on them, so this is slightly going backwards to not hold any lock
when doing it. But doing so in migrate_fd_cleanup() is probably fine (as it
serializes with bql on all the rest qmp commands, neither should migration
thread exist at this point).  Your call; it's still much cleaner.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


