Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAE7CC7A0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmCE-0000Fw-Ga; Tue, 17 Oct 2023 11:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsmCB-0000EW-Gt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsmC7-0001Yh-VB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697557279;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vUDtkEo6oT15O7g7TPwEvfaHUjp/NytM9Enyco2e5wg=;
 b=fP2ySWx3iYB1ZlgnlgZHPQOKHYPNTkFpTcE1tJPSwS3WJF7b/FhVQtlAtCdyqHMaYBk9qi
 fkICUhqz/y42yAMllmrx9x9qZSSAytYM72msoIDTUc7PZbRsjYIFJDQfeR9+gTKsSRJqxj
 +h4JQXuvR+6LsqlFsv2b9kSS+FDvIpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ZoIwGLMpP2a4tv6eU2fViw-1; Tue, 17 Oct 2023 11:41:17 -0400
X-MC-Unique: ZoIwGLMpP2a4tv6eU2fViw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d931872cbso3269206f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557276; x=1698162076;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUDtkEo6oT15O7g7TPwEvfaHUjp/NytM9Enyco2e5wg=;
 b=Ac+TWeZvTepBwrdDY/sOiwc+PfBT/LTzevJUK6N7lldIC5e62q5zuuxqyISWKnU6x1
 Wl9e5hGgnC+wlz5KG9Wc4DoxZtF8K1O+67C0DMNurHcRGYBjjsYZe1T91fuCPP5XlNSX
 mgZJ6wP4JRBluy3cFOQCf+fFbDaR9iIQJAhMauv/Q2ribhvgKjoWLnUOUNH+QGXk2EZR
 Q+x2wC6Tenk8sJL5OX5AbBBnTU54yFZO6OrB7wIxBiomx4xfeyEHoFabrBZHEOwsn8Kp
 OfiEwLHIyULNpDnCO+1Mfbfc6EhwVyalABbCFbRSeZ0X6xCoXr5Gqt5//Ui0/obWQpR2
 a36w==
X-Gm-Message-State: AOJu0Yy6tqbz7UpndB8zWWi5FfIkJxuGucJPimhEGUp1n/CVuIbZeXqO
 HR8CrISfSSKBgjB7yXU9tRyAs4KF/kmt3/Y3T7M2b+I7nmvL90kbRwKAsc1y1LoZkzfyWG5PK0q
 CTHy9ZpQuB175m08=
X-Received: by 2002:a05:6000:1c1:b0:32d:8da0:48d0 with SMTP id
 t1-20020a05600001c100b0032d8da048d0mr2112228wrx.68.1697557276583; 
 Tue, 17 Oct 2023 08:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhUrL46aJFQoQgX92sV50chVzspmLFP1Yim/Mpaj7DIb3lpEeQS4oGbu0eL1SOLnnrkQgksg==
X-Received: by 2002:a05:6000:1c1:b0:32d:8da0:48d0 with SMTP id
 t1-20020a05600001c100b0032d8da048d0mr2112211wrx.68.1697557276284; 
 Tue, 17 Oct 2023 08:41:16 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v7-20020adfebc7000000b003196b1bb528sm37815wrn.64.2023.10.17.08.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:41:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [PATCH v5 4/7] migration: Deprecate block migration
In-Reply-To: <87jzrl5oz0.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Oct 2023 15:59:47 +0200")
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-5-quintela@redhat.com>
 <87jzrl5oz0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 17:41:15 +0200
Message-ID: <87cyxdz278.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>>  #
>> +# @deprecated: Member @block-incremental is deprecated. Use
>
> Two spaces between sentences for consistency, please.

Done.  At least here I did the copy and paste right.

>> diff --git a/migration/block.c b/migration/block.c
>> index b60698d6e2..7682f4fbd2 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -731,6 +731,9 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>>      trace_migration_block_save("setup", block_mig_state.submitted,
>>                                 block_mig_state.transferred);
>>  
>> +    warn_report("block migration is deprecated.  Use blockdev-mirror with"
>> +                "NBD instead.");
>
>        warn_report("block migration is deprecated;"
>                    " use blockdev-mirror with NBD instead.");

Done.

>> +    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
>> +        warn_report("Block migration is deprecated. "
>> +                    "Use blockdev-mirror with NBD instead.");
>
> Likewise.
>
>> +    }
>>  
>>  #ifndef CONFIG_REPLICATION
>>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>> @@ -1386,6 +1391,8 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>      }
>>  
>>      if (params->has_block_incremental) {
>> +        warn_report("Block migration is deprecated. "
>> +                    "Use blockdev-mirror with NBD instead.");
>
> Likewise.
>
>>          s->parameters.block_incremental = params->block_incremental;
>>      }
>>      if (params->has_multifd_channels) {
>
> Other than that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.


