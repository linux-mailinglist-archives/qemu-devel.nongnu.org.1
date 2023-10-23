Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D87D3B0D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:40:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qux1i-0000KL-HO; Mon, 23 Oct 2023 11:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qux1h-0000KC-LJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qux1d-0003p6-Nt
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698075569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ae+Ybj5RCgWcRJNoHAbIB/oPS6lE67oR6resNNaAdE=;
 b=SE/opYCJU9sd7pgIAI9bQeq79l0tP4ON42kQNqoWu/14i0NQUuwBweCvLmtNzwsuhpGIjM
 LHpfd5J9q6VIR14KOb3uqjmcAffFDT2i2RPmepEbc5o1uMs3y1dn7FuxE0ZgrmXHalnSrq
 xFI9QmcGIvKfLv9n/Yu1hhATepLznHE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-PeglwP8ZPsajoGY6T5Oznw-1; Mon, 23 Oct 2023 11:39:27 -0400
X-MC-Unique: PeglwP8ZPsajoGY6T5Oznw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66011f0d521so13377986d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698075567; x=1698680367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ae+Ybj5RCgWcRJNoHAbIB/oPS6lE67oR6resNNaAdE=;
 b=odKjf2Lvd/+Owtjy/ClLP18DlWRCeqJIjtcOYYKg7CrmfdaY+hZ77eYmlYghBJW0u0
 E+e2GubkD45nHXk2WYd40+QXg8RBugZ1R7zP/26ctiTcIeGp+GGGl5/BCnxhgH2PUCDa
 5z6XZ7X57GQFj6KceYpJHAqfSqMLo5d+1Du2IRVWe526wjEW0kbt4mGOOzshfTarsv8F
 6mXmYZ7DRcEzOb54uMplJbrMAN+zH+XPxuAOREgtE2wbhvCMssMbaBbkqnlxJu9Z6MIc
 dJy6iiSqR8wuMfLeoOSXxZo3u5z1ls0yiVLnooLb0xIbc/SJ73E/66W0JUESfC0mcmv/
 AZqA==
X-Gm-Message-State: AOJu0YxmMkSbg0i43BnDDviQpk0E3BGU64vGnl2thVhZiaPAtlw42eGp
 dktzonz23Ye1iLLdfQFnv/GdZmPwYkAUWfL+KkVhG5/AMvOeLofscAGbHddi320U9RuF8kI5mEW
 XO8+XQlNNATVsjfs=
X-Received: by 2002:a05:6214:5509:b0:66d:1178:8729 with SMTP id
 mb9-20020a056214550900b0066d11788729mr10615137qvb.0.1698075567058; 
 Mon, 23 Oct 2023 08:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErOLXVo4LZyyTv6tpjCNPk9mG1QpvDEvabWcEPFydIbpD03bx6WuwQ5FgpADKnUSmwiZEWEQ==
X-Received: by 2002:a05:6214:5509:b0:66d:1178:8729 with SMTP id
 mb9-20020a056214550900b0066d11788729mr10615117qvb.0.1698075566735; 
 Mon, 23 Oct 2023 08:39:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m24-20020ac86898000000b004108ce94882sm2801605qtq.83.2023.10.23.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:39:26 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:39:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Message-ID: <ZTaTrEPcK2yU8MT5@x1n>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 19, 2023 at 01:47:46PM -0700, Steve Sistare wrote:
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
> 
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

What happens if someone migrates with non-shared memory, or without
ignore-shared?  Is it only because it'll be slow saving and loading?

If that's required, we should fail the mode set if (1) non-shared memory is
used, or (2) x-ignore-shared is not enabled.  But I had a feeling it's the
other way round.

Reading the whole series, if it's so far all about "local storage", why
"cpr-reboot"?  Why not "local" or "local storage" as the name?

I had a feeling that this patchset mixed a lot of higher level use case
into the mode definition.  IMHO we should provide clear definition of each
mode on what it does.  It's so far not so clear to me, even if I kind of
know what you plan to do.

I tried again google what CPR is for and found this:

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08541.html

I also prefer spell it out, at least make it clear on what that means..  I
didn't even see "Checkpoint/restart" words mentioned anywhere in this
patchset.

Besides: do you have a tree somewhere for the whole set of latest CPR work?

Thanks,

> +#
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal' ] }
> +  'data': [ 'normal', 'cpr-reboot' ] }
>  
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


