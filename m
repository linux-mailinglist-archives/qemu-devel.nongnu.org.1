Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE27E73EC
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 22:51:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Cub-0003Wg-3x; Thu, 09 Nov 2023 16:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1CuV-0003U7-BX
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1CuK-0006eo-0P
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699566586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yf1ZA4bmxT04JFB+HBgkywHvdzJIbfprVmdFsHkALRU=;
 b=HyLBjZDXu8hI9DQcrDyq5BxY5qZHWWaYBCcZJzpSZUgsUPfHY8ple1zoPnI9H4hHkxFWs5
 VaC0AFUbdrQcv1BJg2YzEeGTUR9MlQIPMQqEGDh1efsVZ1L7p9Z1xwryDShkEQNuBHIaWE
 JGipCT5VUYbtbl26HLBmbSbZ396b96o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-hRz2qjOuPrSl8fhtIPEzuQ-1; Thu, 09 Nov 2023 16:49:45 -0500
X-MC-Unique: hRz2qjOuPrSl8fhtIPEzuQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2804a04e233so1279305a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 13:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699566584; x=1700171384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yf1ZA4bmxT04JFB+HBgkywHvdzJIbfprVmdFsHkALRU=;
 b=lO2lKjdOlBF6Ulp1CNfy+AyHC5fyrJzqXYQjLyO+wKOMlOTe38EbIe7JpUKXgwwsR/
 rqiK/ti6Pgjj9QEbI84law+ipA9sjoZfZ1XUNp13UEAjqUKzH0CrQVo0g3EjL9MvyGju
 hHXBv+8lQRUFO38iBWqGKP8blKMQSLnDzFHLG91kSMnqbd6xnbqjDJIWYj7XEmkFjcDQ
 V6eawmFifVpIdGNrHnLOPMLj1AqHK14QQUa1YBQLhITlb3H40MT6m2ycWg+wXgaaPjVn
 hmlEwo4S2zJPBaBVBTsrPDln5SWY8t1uVz/NGylEirpkfIaQtA7Mj4M3Uj7w4j9/whvg
 YVjg==
X-Gm-Message-State: AOJu0YzhqwgjExQphTU7VzPo674P/yl7xEU78RJNYzk9/z6kLS18K60/
 lc63n8STWkkhWpg3AXs3x+UDT+1ToqLtu3sr/f0vPxcetZNWuWtgO14SQsRW9l+sReA+Nd3XD+M
 Ea9lN1wJa6LSNuh+j2jpC082bMjvTmik=
X-Received: by 2002:a17:90b:4ac9:b0:27d:1571:f683 with SMTP id
 mh9-20020a17090b4ac900b0027d1571f683mr2795221pjb.44.1699566583951; 
 Thu, 09 Nov 2023 13:49:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt/T8O0MJB17YtxbT0UFV94EMvh9IVD+YMZR0cqfhhT2y9olTMktBg9JZNA/HJgrnrRoZMB4CJBJ8sQ7/nrhM=
X-Received: by 2002:a17:90b:4ac9:b0:27d:1571:f683 with SMTP id
 mh9-20020a17090b4ac900b0027d1571f683mr2795200pjb.44.1699566583669; Thu, 09
 Nov 2023 13:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-4-davydov-max@yandex-team.ru>
In-Reply-To: <20231108153827.39692-4-davydov-max@yandex-team.ru>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Nov 2023 16:49:32 -0500
Message-ID: <CAFn=p-Yvtf4-Uhrk3yt7LCy_szdWx2Yx96CPRcY7BLfmcAO-dg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] python: add binary
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com, 
 stefanha@redhat.com, thuth@redhat.com, darren.kenny@oracle.com, 
 Qiuhao.Li@outlook.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Nov 8, 2023 at 10:39=E2=80=AFAM Maksim Davydov
<davydov-max@yandex-team.ru> wrote:
>
> Add a supportive property to access the path to the qemu binary
>
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  python/qemu/machine/machine.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine=
.py
> index 31cb9d617d..78436403b2 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -328,6 +328,11 @@ def args(self) -> List[str]:
>          """Returns the list of arguments given to the QEMU binary."""
>          return self._args
>
> +    @property
> +    def binary(self) -> str:
> +        """Returns path to the qemu binary"""
> +        return self._binary
> +
>      def _pre_launch(self) -> None:
>          if self._qmp_set:
>              if self._monitor_address is None:
> --
> 2.34.1
>
>

'kay.

Reviewed-by: John Snow <jsnow@redhat.com>


