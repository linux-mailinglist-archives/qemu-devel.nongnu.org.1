Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229177D0C34
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtm4Q-00035A-CG; Fri, 20 Oct 2023 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtm4D-0002yx-Tc
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtm4C-0007zR-7a
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697795115;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U9rxUoGvaLYjq6V4KKpBXU648fw9W30DjOYgK5EhH00=;
 b=JO+MQS/jP+S5jZxGGmIx5aYHkBn62tShbXa2F3YBgFdi3jhbicBfMjPM5jOZKQy0RWLCxm
 7+FIH6dOkozxdw/3Pxysbo0Ee5NMgcRMnL+CXXdzUkuPq9I+hhg8kPCgOaoakabgNsPMVg
 ZbLwc6UYeUvVmuEXi5iiyttRh9AwRg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-aI9mK_W_M9GchaGZ-csDiw-1; Fri, 20 Oct 2023 05:45:11 -0400
X-MC-Unique: aI9mK_W_M9GchaGZ-csDiw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so3947655e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697795110; x=1698399910;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9rxUoGvaLYjq6V4KKpBXU648fw9W30DjOYgK5EhH00=;
 b=s7WpzBcXPACULW+WDEjwFwY2tyI1hWPM5wzSYzbpOp2zlns0i0WxBgmg6PSUCkKA2a
 oexxbR2fn9NmdXRGrlhdalfcWS/P+CSzzU/cSI9yqwVHffn2psK6im8VM7ngHIBgBvRc
 2umUKaW+08R7jLxPrikkqIuose1+2DkRiuC9F42i0BhtX+SN5uY4Ptz5G5aTCIU4NB8A
 Qj+ptOZlqQ2uZVbiw1Zgvpsm2Ypq/ExNNvjmlrrEbYYnKWriXLE8+Cw65KnPnR+ScRo4
 +tiODePp9Y9BUfvtCwXfQPhIwm0TyTZz+oY+AcqDrdd3CtD0aUu9VX7kM8uuGj9qZNF0
 xBbw==
X-Gm-Message-State: AOJu0YwiS61rYWeXIBUyBj3gg3stQ5GXWrvVwDi1cl8H0S2ZkBFHqL/c
 rk5mt+2IQ8bo8YBK3CGwTOT+isDwA6yCjw3NBDbSH16YQfoCussgwIPeTGU3Wtd+uw3VgsQQ1Jw
 sVb5MAcngsg3AM0M=
X-Received: by 2002:a05:600c:26d4:b0:406:8496:bd8b with SMTP id
 20-20020a05600c26d400b004068496bd8bmr962603wmv.9.1697795110563; 
 Fri, 20 Oct 2023 02:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPJjBHOveYEpBKlm9EP4IuT5+EddbN+ABLMxVzoYg0CXyiQqhKXSb4ldAWvOCeQ5rZ94E/7A==
X-Received: by 2002:a05:600c:26d4:b0:406:8496:bd8b with SMTP id
 20-20020a05600c26d400b004068496bd8bmr962586wmv.9.1697795110209; 
 Fri, 20 Oct 2023 02:45:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 ay20-20020a05600c1e1400b00407460234f9sm1755254wmb.21.2023.10.20.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:45:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
In-Reply-To: <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 19 Oct 2023 13:47:46 -0700")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:45:08 +0200
Message-ID: <87mswdzkyj.fsf@secure.mitica>
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

Steve Sistare <steven.sistare@oracle.com> wrote:
> Add the cpr-reboot migration mode.  Usage:
>
> $ qemu-system-$arch -monitor stdio ...
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) migrate_set_capability x-ignore-shared on
> (qemu) migrate_set_parameter mode cpr-reboot
> (qemu) migrate -d file:vm.state
> (qemu) info status
> VM status: paused (postmigrate)
> (qemu) quit
>
> $ qemu-system-$arch -monitor stdio -incoming defer ...
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) migrate_set_capability x-ignore-shared on
> (qemu) migrate_set_parameter mode cpr-reboot
> (qemu) migrate_incoming file:vm.state
> (qemu) info status
> VM status: running
>
> In this mode, the migrate command saves state to a file, allowing one
> to quit qemu, reboot to an updated kernel, and restart an updated version
> of qemu.  The caller must specify a migration URI that writes to and reads
> from a file.  Unlike normal mode, the use of certain local storage options
> does not block the migration, but the caller must not modify guest block
> devices between the quit and restart.  The guest RAM memory-backend must
> be shared, and the @x-ignore-shared migration capability must be set,
> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
> reboot, such as by backing it with a dax device, but this is not enforced.
> The restarted qemu arguments must match those used to initially start qemu,
> plus the -incoming option.

Please, add this message to doc/<somewhere> instead (or additionally) to
the commit log.

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 184fb78..2d862fa 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -620,9 +620,23 @@
>  #
>  # @normal: the original form of migration. (since 8.2)
>  #
> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
> +#              quit qemu, reboot to an updated kernel, and restart an updated
> +#              version of qemu.  The caller must specify a migration URI
> +#              that writes to and reads from a file.  Unlike normal mode,
> +#              the use of certain local storage options does not block the
> +#              migration, but the caller must not modify guest block devices
> +#              between the quit and restart.  The guest RAM memory-backend
> +#              must be shared, and the @x-ignore-shared migration capability
> +#              must be set, to avoid saving it to the file.  Guest RAM must
> +#              be non-volatile across reboot, such as by backing it with
> +#              a dax device, but this is not enforced.  The restarted qemu
> +#              arguments must match those used to initially start qemu, plus
> +#              the -incoming option. (since 8.2)
> +#
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal' ] }
> +  'data': [ 'normal', 'cpr-reboot' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:

It only works with file backend, and we don't have any check for that.
Wondering how to add that check.

Additionally, you are not adding a migration test that does exactly what
you put there in the comment.

Thanks, Juan.


