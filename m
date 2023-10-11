Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579397C5507
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:13:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZ0w-0000KD-R0; Wed, 11 Oct 2023 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZ0u-0000K0-S6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZ0s-0001vm-Vk
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697029954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=omMFA2BFwxkht+iyiplRXUh2rwdf/BXFf9FYID90z6I=;
 b=bkONTKcn19f7dYm5DNwWi1q14u99p28PuZyhGUjrXFHrDXoaROMcgFqsredyVBpZ9dY5MT
 JlxNdp6swVTomJ1igVcmKyLA/LeQhcjlF8mpMfKTY5CjGUNXLWUcWUBbgPZd39yJ2WvQWx
 zKJS5UPvOHgeJ2O3IWzt6trqliy4dUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-CX2eeVDiNJqlZlDWHBJIVA-1; Wed, 11 Oct 2023 09:12:32 -0400
X-MC-Unique: CX2eeVDiNJqlZlDWHBJIVA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so488861f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029951; x=1697634751;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omMFA2BFwxkht+iyiplRXUh2rwdf/BXFf9FYID90z6I=;
 b=MwhR91licX4ZkpMvsAbR8xhdbrQWEUIDZYDZYODTu7STxosIUmntsjxGyeLYX2DbbH
 T+rB1YYOCOimxARvaVjXvY6Cebgzr/PbZiuXfRwtlhZuET4Xfjxlwx9EwgRgu67WfSSC
 KSRZVUjNgwbbQqVIhfzYSSGGhK1C1grFwJNqxlQ5wgVF2RWvn7XBKSAAltbk/AOHj8IP
 kwZJdBZYvOEGF2JH9rSPXaR4l4otYp+l0dUdOwuZ5L4cZXHGIR0dSK14e5JEzCuQwWLV
 chFqxrhi/3YQzctNnN9wwJiKPc9odfwHw6s3aclUPR2ui3n9cW+eMiPiOrV2/Cg5rw3t
 tM6Q==
X-Gm-Message-State: AOJu0YysdPlXhz2wYab5wJ+pSkzD9Dkw9xCNeW7Auq2qy/nVmNcyvlwk
 hZJz16evhj3NaiLr5vkDKSYzcx1bUR0ZKZdDdgSHpNMi7uLH2mjGgmjfHtPEFw4UGt75KKu+d1g
 PzLtSq9814/S+a6E=
X-Received: by 2002:a05:6000:1c09:b0:329:6b35:d141 with SMTP id
 ba9-20020a0560001c0900b003296b35d141mr16255356wrb.44.1697029951295; 
 Wed, 11 Oct 2023 06:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn41OuXOhoeKde60W2JwGpcC01611sbpNDXadZ4NwLG33/lEFoKYBT579aXAqtgyR6skUuTg==
X-Received: by 2002:a05:6000:1c09:b0:329:6b35:d141 with SMTP id
 ba9-20020a0560001c0900b003296b35d141mr16255338wrb.44.1697029950981; 
 Wed, 11 Oct 2023 06:12:30 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b6-20020adfee86000000b0031f300a4c26sm15392683wro.93.2023.10.11.06.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:12:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/6] migration: Add the configuration vmstate to the
 json writer
In-Reply-To: <20231009184326.15777-2-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:21 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:12:29 +0200
Message-ID: <87edi1b8w2.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> From: Nikolay Borisov <nborisov@suse.com>
>
> Make the migration json writer part of MigrationState struct, allowing
> the 'configuration' object be serialized to json.
>
> This will facilitate the parsing of the 'configuration' object in the
> next patch that fixes analyze-migration.py for arm.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.

>          qemu_put_byte(f, QEMU_VM_CONFIGURATION);
> -        vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
> +
> +        /*
> +         * This starts the main json object and is paired with the
> +         * json_writer_end_object in
> +         * qemu_savevm_state_complete_precopy_non_iterable
> +         */
> +        json_writer_start_object(s->vmdesc, NULL);

This don't depend of this patch, but it is ugly as hell.

Can we create:

json_write_start_main_object(s->vmdesc);

(equivalent for end)

And forbid json_writer_start_object() for taking a NULL parameter?

Later, Juan.


