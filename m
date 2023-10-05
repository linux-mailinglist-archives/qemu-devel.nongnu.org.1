Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C497B9B20
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHwf-0004nx-Bs; Thu, 05 Oct 2023 02:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHwX-0004fs-6i
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHwV-00062t-Q9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696487679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DDCOHPLbZQzSYOkSAgMFQJ87bpYXNf9EETfNEEqRCk=;
 b=WUmIsKH0awKHX5ommRM8CWH30zxPJ22/UYpl7jEpnwzwsDLq6NT2lVznbbFBDxBjHMWjGI
 WQo5H5LNhvRmvl7BEr/vmEwPTwyumWcz0JYPLxa0UtjplRenEqHR9Fy+4KRND/fzAdPVHU
 Ziqvh/MLph7BUoZFGvios9eKNjmYX9U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-I_zu8e7qOCSsD7a6KSDadQ-1; Thu, 05 Oct 2023 02:34:27 -0400
X-MC-Unique: I_zu8e7qOCSsD7a6KSDadQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso541275f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696487666; x=1697092466;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5DDCOHPLbZQzSYOkSAgMFQJ87bpYXNf9EETfNEEqRCk=;
 b=THTMd0QkdxU35JlaP1IrZ3N9Hp2RRuuZ4EFZmgLXe79G/6ITxn0u5AtG7YwQynmOND
 PmoskMa3Y9YBvKqqzgNNC2VLVhhPnjMFRdsKkAdswnPXv4EcEBC/7NDBHnBDq50G1lf9
 6kpdwMNjkAUn33f+71Rgqc/Zs7E/WtQWeO6FCLvjWS6m1YZdwfxJDM8YIpVHS/oThTpX
 JxZ2DfmOIfWVs0he/3nBCSq3NtQScdzz9VYR49nlbQc5qtueGMlHSwBiZsDZ7sikzUVA
 WiDlgpVCqFrHA04N9mvCkgOZYYg5rzDCSJhhy17b2DYEYsifqYlVwkH5GL2PQch2DTO3
 Xldg==
X-Gm-Message-State: AOJu0YzcrqUNb8JM7MNXAHjVw1JLnTDSNxl8SMyUBebJsMhf8gYUui8Q
 zECkj8PZo++qe5+SFpXtff5iXm2F3kDRcP/MBin/I7Id6jF2KcDrtcvqeGOlh3Wn3p6Szjk7ykg
 pq5gq3IBKvvG8eqE=
X-Received: by 2002:adf:dd82:0:b0:324:84bc:d59e with SMTP id
 x2-20020adfdd82000000b0032484bcd59emr3983346wrl.22.1696487666279; 
 Wed, 04 Oct 2023 23:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWo9kB+Z5RhtfPRBXOA4auEGeVKvMCymITTxXxOh7LUu8tf9ssE0VSgdL42lp+zTYiH+5r5A==
X-Received: by 2002:adf:dd82:0:b0:324:84bc:d59e with SMTP id
 x2-20020adfdd82000000b0032484bcd59emr3983330wrl.22.1696487666025; 
 Wed, 04 Oct 2023 23:34:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p14-20020a056000018e00b0031984b370f2sm957284wrx.47.2023.10.04.23.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 23:34:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
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
Subject: Re: [PATCH v2 11/22] qapi: Inline QERR_INVALID_PARAMETER_VALUE
 definition (constant value)
In-Reply-To: <20231005045041.52649-12-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:28
 +0200")
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-12-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 08:34:24 +0200
Message-ID: <87a5sxr30v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> vcpu_dirty_limit
>
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
> Then manually splitting lines over 90 characters.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


