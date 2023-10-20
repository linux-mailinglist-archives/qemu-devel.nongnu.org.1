Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 896677D0BBF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlpS-0000VA-3i; Fri, 20 Oct 2023 05:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlpJ-0000Tl-RR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlpH-0004Ek-VG
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4s9JIQQzXCYoDjM1fNs4AqFhS2ha0vXmxD+yRrYS1Cg=;
 b=hrJOzaqxkrIygSKgtCKIW/qhypyK34w/wPugih5twWmkA2EzaGMIwc4FtdfyIeDA5IdRv/
 M73/NKMkBFb28sAwunpYUqgMmLsD6GazOrrpQqBmjgV+sRVAZ/D4ugtcBKu/S2IA/+d0tk
 nLPrARRVvIcCfihDSd9HzxTuePLhoJ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-598j9KkNMFGo3U5C4V2m7Q-1; Fri, 20 Oct 2023 05:29:49 -0400
X-MC-Unique: 598j9KkNMFGo3U5C4V2m7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so3782715e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794188; x=1698398988;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4s9JIQQzXCYoDjM1fNs4AqFhS2ha0vXmxD+yRrYS1Cg=;
 b=rHBKpe7Sfv3oeLzNFSG7WtgOIgVth5xrh0/c+BM2dyt2D35z8MIjY00XUYPIXEhZ0H
 0n1y+PwA39IeZyqYOdi9whXa4ZZ+ztjAFErzrtalwTBUwmGMM3DkexdhNe8+mUEs4b47
 26LWh9JwEMkXtQ7SVuw0UF3iRcBj5CiYAz085bRF0gm4HF7OCTD3sR+VD8T3rNc5/bsR
 wB9KIsJ0swpNIH9c7JrwdO1s3caIOuhovzAgKUkqC2F9KnPfpyIUr3viLoMXwXg5Zzjs
 /74LxEfC9/6VBu4SlUz2CitkM28IDcAQWUEastQ9eaHbdlHMHb4f/OnHNhIchOp2LLLB
 RiLw==
X-Gm-Message-State: AOJu0YzjoeyFsj7kpqf+RRft4jN+g+PDmfg0C0p5dsVRO9ABmpWQSAX+
 93DnqUWj5qzFwBwhJTkSLSHrXO1Hfk3fj4c2xB/wVbejiyeD2Q4DNm6uQkPIlj5ZMYVkeQTb26w
 FvQWmxS+1ujdJQXM=
X-Received: by 2002:a05:600c:19d1:b0:405:3955:5881 with SMTP id
 u17-20020a05600c19d100b0040539555881mr999866wmq.36.1697794187858; 
 Fri, 20 Oct 2023 02:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGGnXlCVddoEsrz2J58wEqp2YXXLmmzC1WcSzLEsfIz5gbUpDTm/SWu9qT1Gov96Kgxo/ULg==
X-Received: by 2002:a05:600c:19d1:b0:405:3955:5881 with SMTP id
 u17-20020a05600c19d100b0040539555881mr999857wmq.36.1697794187474; 
 Fri, 20 Oct 2023 02:29:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b00407752f5ab6sm1746495wmo.6.2023.10.20.02.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:29:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 1/4] migration: mode parameter
In-Reply-To: <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 19 Oct 2023 13:47:43 -0700")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:29:46 +0200
Message-ID: <8734y51w1h.fsf@secure.mitica>
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

Steve Sistare <steven.sistare@oracle.com> wrote:
> Create a mode migration parameter that can be used to select alternate
> migration algorithms.  The default mode is normal, representing the
> current migration algorithm, and does not need to be explicitly set.
>
> No functional change until a new mode is added, except that the mode is
> shown by the 'info migrate' command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[... qdev definition ...]

Looks legit, but I am not an expert here.


> @@ -867,6 +870,13 @@ uint64_t migrate_xbzrle_cache_size(void)
>      return s->parameters.xbzrle_cache_size;
>  }
>  
> +MigMode migrate_mode(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.mode;
> +}
> +

Inside parameters, I try to get the functions sorted by name.  the same
for options.h

> diff --git a/qapi/migration.json b/qapi/migration.json
> index db3df12..184fb78 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -616,6 +616,15 @@
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>  
>  ##
> +# @MigMode:
> +#
> +# @normal: the original form of migration. (since 8.2)
> +#
> +##
> +{ 'enum': 'MigMode',
> +  'data': [ 'normal' ] }
> +
> +##

Here you only have normal, but in qdev you also have exec.


>  # @BitmapMigrationBitmapAliasTransform:
>  #
>  # @persistent: If present, the bitmap will be made persistent or
> @@ -675,6 +684,9 @@
>  #
>  # Migration parameters enumeration
>  #
> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
> +#        (Since 8.2)
> +#

You normally put comments and values at the end of the comments and
sections. Your sshould be last.

Feel free to use a single line in the json.  More than one value for
line make it a bit more compress, but makes changes more complicated.

Rest of the patch feels right.

Thanks, Juan.


