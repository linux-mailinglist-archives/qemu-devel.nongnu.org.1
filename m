Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283A831350
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:45:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQN57-0005qd-5u; Thu, 18 Jan 2024 02:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQN4t-0005qF-DO
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQN4r-0002dQ-Rs
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705563879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=quCotmFVIk5MQB01sfwFKuMO1zdvfO+rfdBgacrMr6k=;
 b=PTpf9IwmrS+RCgIl+wXeLtwvKZJM/1n3iMnFqOTiBw/lSwT9A9nfTTQY+vMBUQnfl08Q/H
 /2nZqhu3COPjuUb0TpxAeqmg2+v0jpm4qZQMyOe9R6CxRP//Jnn3uRu6FXSh8MCYzUfDAp
 k6UdWD+Kist7OtqXWWV3YiObUlVtJ3c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-RkilOOj3MHifDxeu2guimQ-1; Thu, 18 Jan 2024 02:44:37 -0500
X-MC-Unique: RkilOOj3MHifDxeu2guimQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso1407939a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705563876; x=1706168676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quCotmFVIk5MQB01sfwFKuMO1zdvfO+rfdBgacrMr6k=;
 b=E8VjL+ERjEkwjSQRkyuDAjpic8GbJiqLAGZH9hY1ybeMsycquDLG+6yoBVH9ynPzVn
 wQhq3d0sA72laEf0HB/7V3O+y2BCepXVM0UYju7kQdzCNF/b7mvMq+bEw5E1SOuIAdMr
 G1YD8qXTyD4lZT2GP6GhdecojTON+6fxUpMre5HwjbfztTDSIYkbfgjJYdeeRGC9wTSy
 2rwbAXZPS3xTRB3W/00nNqlRiOI111fA8Z331PxglvjsWKG5gyFLtzjhjLRgz+/AFrzT
 FiykkDeLKsN0ZBfhwS6JfePNUzXpi2VvGDSmXYXH6YSySl+h2rQF88lVSWdVPFsm/SSC
 ijng==
X-Gm-Message-State: AOJu0Yz4i6+1sJjqc9UglEAlAzmsb+n8azvOekmomqvZqCnhEQWHkBrH
 8GRvnPTQHQYcM1kwWjsbHqYD1iBHHLOk3TuJW6Jxt4YaRcuL7JdB1JAw4Uck7kmREcQ2wN36EFo
 BfXyMdEW5V9c2s3tPU2nnpGAsVz4/OwXlSxEGDf3VsJp4lW60/oa+
X-Received: by 2002:a17:90b:d97:b0:28e:3989:c49f with SMTP id
 bg23-20020a17090b0d9700b0028e3989c49fmr844594pjb.1.1705563876176; 
 Wed, 17 Jan 2024 23:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFehFq25ebFGwgYJkKK/S+6or4D7ZtkYlmnpffkYQnqU6Kl+EEOVyV53Fi5HX+zSlEFv699gQ==
X-Received: by 2002:a17:90b:d97:b0:28e:3989:c49f with SMTP id
 bg23-20020a17090b0d9700b0028e3989c49fmr844585pjb.1.1705563875898; 
 Wed, 17 Jan 2024 23:44:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t13-20020a17090aae0d00b0028ce9c709e4sm996555pjq.26.2024.01.17.23.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 23:44:35 -0800 (PST)
Date: Thu, 18 Jan 2024 15:44:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes
 a discontiguous iovec
Message-ID: <ZajW26IiC8JMWSO9@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZaYpKorhxEi3CEmv@x1n>
 <875xztxhyh.fsf@suse.de> <ZaeiXra5hLSo0jnt@x1n>
 <87fryvdeco.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fryvdeco.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 17, 2024 at 03:06:15PM -0300, Fabiano Rosas wrote:
> Oh no, you're right. Because of p->pending_job. And thinking about
> p->pending_job, wouldn't a trylock to the same job while being more
> explicit?
> 
>     next_channel %= migrate_multifd_channels();
>     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
>         p = &multifd_send_state->params[i];
> 
>         if(qemu_mutex_trylock(&p->mutex)) {
>             if (p->quit) {
>                 error_report("%s: channel %d has already quit!", __func__, i);
>                 qemu_mutex_unlock(&p->mutex);
>                 return -1;
>             }
>             next_channel = (i + 1) % migrate_multifd_channels();
>             break;
>         } else {
>             /* channel still busy, try the next one */
>         }
>     }
>     multifd_send_state->pages = p->pages;
>     p->pages = pages;
>     qemu_mutex_unlock(&p->mutex);

We probably can't for now; multifd_send_thread() will unlock the mutex
before the iochannel write()s, while the write()s will need those fields.

> Ok, then I can take block->pages_offset and block->host from the
> ramblock. I think I prefer something like this, that way we can be
> explicit about the migration assumptions.

I'm glad we reached an initial consensus.  Yes let's put that in
migration/; I won't expect this code will be used by other iochannel users.

-- 
Peter Xu


