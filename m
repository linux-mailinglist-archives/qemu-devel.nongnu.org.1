Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029997B81E6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2cf-0002Tv-7h; Wed, 04 Oct 2023 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2ca-0002RT-3Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2cW-0001ib-ER
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696428779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X9AQZhLCwLgH9ynUOBaY6IrchR7vDj5l0M4l2rHMBTs=;
 b=OkPwu6g444dM6rVT66pPzg9ZxIjVCrskfK8XJh0QN68lGEMRZN2ZBLwVdar9uN8uFqj0UR
 tn8aY7m6KVYu5yxz7BdtOlQPQIyi7Jr4ACAwgmIe5S7XowCsL08rUf22K/EJfOZCvnLDyr
 SZ9Q8o9BvYYE8J5BhMMxr3M44bnQJI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-gOilgjjpPJ-Ep7aSuq3VMg-1; Wed, 04 Oct 2023 10:12:57 -0400
X-MC-Unique: gOilgjjpPJ-Ep7aSuq3VMg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32661ca30d9so1542714f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428776; x=1697033576;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9AQZhLCwLgH9ynUOBaY6IrchR7vDj5l0M4l2rHMBTs=;
 b=cvozBiwfFoDzIiUSVXJTN3CkEBvtuhM3E2bZ/+TMZ41J6waagmHP6Uf7feb19SJqQm
 tDbc77GTJxymD/174ogqRuEvL1vIHaoQ9pti+Iis1pE0hDjXRl7pYelCoKR0RE44QWfc
 LSmtSTv78py8ILG5TeDmS3fj7xpjtSS9GITPyYfs2iCxTCzxzXeWKLc0fiGBOABU7/1x
 vHoSUH+n+iDruT+GNKc3RbMcVwT+bfIWzDDU7erLLXUJn8PdKT1JGsDL9evjuWQr9FnZ
 14MFcFvTYY5T/CsEdCgYr7ujpuTy5jgiFU09bq0Gs20iOxj46nqQvLfh+FNSZSGu7q34
 IhDw==
X-Gm-Message-State: AOJu0YytaIsFEuviDEHoJH5/QB1W1hffTHT01yvSibOYQ1pxSPfU6U/g
 V2VzaBYHf2VYlSaGI1N0chaNGI1yi5eBCBe8Yu64LYCHpk8ojjBWf4hPrdPoBn0sVLQJYXSH4Zt
 MusRHNDOZ+jWLutM=
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id
 m7-20020a5d6a07000000b00314350a6912mr2199301wru.36.1696428776648; 
 Wed, 04 Oct 2023 07:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgIS1cPe4Woeg4GBKBP92l6lTShKoy4OIZI8iqGJRV+RJdLNZQcv4nghYlQ/auRUhu6W/NYA==
X-Received: by 2002:a5d:6a07:0:b0:314:350a:6912 with SMTP id
 m7-20020a5d6a07000000b00314350a6912mr2199285wru.36.1696428776319; 
 Wed, 04 Oct 2023 07:12:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 g9-20020a5d46c9000000b0031ae8d86af4sm4128151wrs.103.2023.10.04.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:12:55 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v5 4/6] migration: Set migration status early in
 incoming side
In-Reply-To: <20230712190742.22294-5-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 12 Jul 2023 16:07:40 -0300")
References: <20230712190742.22294-1-farosas@suse.de>
 <20230712190742.22294-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:12:54 +0200
Message-ID: <87r0ma1no9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We are sending a migration event of MIGRATION_STATUS_SETUP at
> qemu_start_incoming_migration but never actually setting the state.
>
> This creates a window between qmp_migrate_incoming and
> process_incoming_migration_co where the migration status is still
> MIGRATION_STATUS_NONE. Calling query-migrate during this time will
> return an empty response even though the incoming migration command
> has already been issued.
>
> Commit 7cf1fe6d68 ("migration: Add migration events on target side")
> has added support to the 'events' capability to the incoming part of
> migration, but chose to send the SETUP event without setting the
> state. I'm assuming this was a mistake.
>
> This introduces a change in behavior, any QMP client waiting for the
> SETUP event will hang, unless it has previously enabled the 'events'
> capability. Having the capability enabled is sufficient to continue to
> receive the event.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


