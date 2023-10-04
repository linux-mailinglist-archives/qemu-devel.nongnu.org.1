Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF107B887C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6Pe-00076Z-F4; Wed, 04 Oct 2023 14:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6P8-0006kj-9s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6P4-0007tC-P0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696443317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GimX+cA1aKh/KM4sS+CQCOjohDRkBYnOfoOQOGJfBo=;
 b=KuFj5Qv3RmrAv6wUMm13ERwJGPESg7dp6HgWThrV5PJve7oZUbsa3K4J812O0ztndzFBKs
 Gt1OEYxBV1Xyc0tMw8FRMuecYu+cfUzymHDyt1L9qEPOFogUu56biMDN/jGXjbDn/0mUBK
 C9k0Qh+LH8nc/+OyQYJ53pNU3NiqYik=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-d4vrPmFIMti3t8jQ3NvS0A-1; Wed, 04 Oct 2023 14:15:16 -0400
X-MC-Unique: d4vrPmFIMti3t8jQ3NvS0A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-321726b0238so91766f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443315; x=1697048115;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GimX+cA1aKh/KM4sS+CQCOjohDRkBYnOfoOQOGJfBo=;
 b=j1iZCoBRHhW+X2L+kpLFwC+W4YLtmvG6c3aIerLPwxRJqZvSSrRZzxre62cP23w5bQ
 XeAZM9rVvAPKCisE6hLCJpzuKrmW0eT4XJJh69v5DXnH9qc/SX8oW82KQ8ZCSl5LlcN9
 lubuzPyEe7aSr7Pz6WKTw6TAkq7sfJvB16zt6d7iS9EyqmCadXl6ZrJ2usMrMeUGA5Co
 K3GqnxKhOdDJz9+/wLh06RI0BvXlLWlxS/18l+tuUGjR6iD/qBXxpljO4QzWb2rSym52
 MPx/Wkuisv2d2T9oItr3Z1sR8GTQWDkRwIoLmF3h6Vlao2wvN6TXsuT5ei/b3ohdialB
 lN9g==
X-Gm-Message-State: AOJu0YxwCGbevr+750RUOTLcGN9XhoUQh09cM9dIR1uiJSNZ3aCJufJv
 wBjicCR1cjXE8eLTZiEEYjXPVmQPHPZMW1+QIqJGGvgwk69xDKZof6iCk8kM0aVM+ckmLqj11ks
 IPAC8chLHkSpnasw=
X-Received: by 2002:a5d:6445:0:b0:322:6201:6049 with SMTP id
 d5-20020a5d6445000000b0032262016049mr2611795wrw.39.1696443314896; 
 Wed, 04 Oct 2023 11:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+qshyZc0xLC7y64wkvSSX+/WvV5e3QvIkKDgTzNpguo5kppgw8XDtaMCPBbyg/gB9QVia1A==
X-Received: by 2002:a5d:6445:0:b0:322:6201:6049 with SMTP id
 d5-20020a5d6445000000b0032262016049mr2611774wrw.39.1696443314563; 
 Wed, 04 Oct 2023 11:15:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e6-20020adfef06000000b003197b85bad2sm4579623wro.79.2023.10.04.11.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:15:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>,  Alberto Garcia
 <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  John Snow <jsnow@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 10/21] qapi: Inline QERR_INVALID_PARAMETER_VALUE
 definition (constant value)
In-Reply-To: <20231004173158.42591-11-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 19:31:45
 +0200")
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-11-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:15:12 +0200
Message-ID: <871qeas18v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using the following
> coccinelle semantic patch:
>
>     @match@
>     expression errp;
>     constant param;
>     constant value;
>     @@
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>
>     @script:python strformat depends on match@
>     param << match.param;
>     value << match.value;
>     fixedfmt; // new var
>     @@
>     fixedfmt =3D "\"Parameter '%s' expects %s\"" % (param[1:-1], value[1:=
-1])
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     constant match.param;
>     constant match.value;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>     +    error_setg(errp, fixedfmt);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

And like the approach, but=20

>      if (granularity !=3D 0 && (granularity < 512 || granularity > 104857=
6 * 64)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
> -                   "a value in range [512B, 64MB]");
> +        error_setg(errp,
> +                   "Parameter 'granularity' expects a value in range [51=
2B, 64MB]");
>          return;

There are several lines like this one that become way bigger than 80
characters.

Later, Juan.

PD.  No, I have no clue about how to convince coccinelle to obey qemu
     indentation rules.


