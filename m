Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855507B887D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6Ph-000781-AE; Wed, 04 Oct 2023 14:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6PJ-0006pe-Fs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6PG-0007vU-SJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696443333;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZdeQOwpAjNhw7qtpgYcUXCh3y1KKQKJaqogrumSLGU=;
 b=h3FGPw1uaWnnRsO6SDpfqtuPXwUGgoLY3HDNw41i7hMtA3hhoKjn8dqOB8hG8nFF4m7RSX
 EWD2kkMlUzzCoJqB09jdFCb9jJwq1Y/BQig+n04l1Pq0MyipZ6XHmNDvziQaGs7Yzeu5se
 x8UEbRTcAMojIIRessdLoxtCuz6dmbg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466--sc4DHKfMr6eAP1G47DNCQ-1; Wed, 04 Oct 2023 14:15:31 -0400
X-MC-Unique: -sc4DHKfMr6eAP1G47DNCQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so971075e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443330; x=1697048130;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZdeQOwpAjNhw7qtpgYcUXCh3y1KKQKJaqogrumSLGU=;
 b=VdBslW8tIzbY41Bs1thvr/SaTVo87XNLL/lOAC+wzqmxMQWiYlnxH/ud52GPuhC1/6
 v6/W2+NsAWOkv7oh4J4YHiubOAiadbv6gjqdW7NZBmEB7LlZ8ChQT2sXzYS4Cw3+Cf6y
 TOi2diOJluqELNVsVFpmwAUIvvoMBz7tXhyDh8yvIilw0pF21vzxzyr9FMxcOERIxo15
 LCDOe4MeE8niSjcjLPDaowYaGbpYwOlUx+x3+OLvAx+0CSrq48MyUNh4MAdbSVSKBzJf
 haOLhksCVKVQXZlxgbE6YjsIcMs7tjR4VG+ZjaLv4dXG6io6q6XCUYmCsvOMWyb6ZQPG
 o+KA==
X-Gm-Message-State: AOJu0YxuQOAfUhjw7/pEiVXvG0iT4uVA8UjytRfR7om4J07p0B0kYtiK
 xVj+5+ZA+1vttnBc+jZ7xcANQwuWlovUCUCfzU6kkQxZF68k4kGMaVzTMYNNuIf3NGpUa/KICQO
 5sAHlVSwu5qHeVnw=
X-Received: by 2002:a05:600c:2195:b0:406:53aa:7a5f with SMTP id
 e21-20020a05600c219500b0040653aa7a5fmr2887169wme.10.1696443330707; 
 Wed, 04 Oct 2023 11:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaaoiaT4I2n7MYgw4ZSunBz4ENwVhEjQz2qEMK4DpkDa0AKvDQxgt/NhCR5dQCOPu0L78qsQ==
X-Received: by 2002:a05:600c:2195:b0:406:53aa:7a5f with SMTP id
 e21-20020a05600c219500b0040653aa7a5fmr2887140wme.10.1696443330361; 
 Wed, 04 Oct 2023 11:15:30 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p9-20020adfcc89000000b00326028b4dd5sm4537759wrj.113.2023.10.04.11.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:15:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,  Fam Zheng <fam@euphon.net>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  =?utf-8?Q?Marc-And?=
 =?utf-8?Q?r=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 13/21] qapi: Inline and remove QERR_IO_ERROR definition
In-Reply-To: <20231004173158.42591-14-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 19:31:48
 +0200")
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-14-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:15:28 +0200
Message-ID: <87wmw2qmnz.fsf@secure.mitica>
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
> Mechanical transformation using:
>
>   $ sed -i -e 's/QERR_IO_ERROR/"An IO error has occurred"/' \
>     $(git grep -wl QERR_IO_ERROR)
>
> then manually removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


