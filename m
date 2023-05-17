Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C22647069D9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHDd-0007Ak-D4; Wed, 17 May 2023 09:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pzHDb-0007Ac-Rj
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pzHDa-0003DS-2C
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684330165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0HjJBZfFbalmQk+/E5s2NCc60wE7ImQMAqU0QQPPLk=;
 b=H547RlJH25v4I8udxCQpeO9LBnsreyczmv+mZpbHWDJSoy/W3GlxitEy+3jTEr+hc0K+Oy
 5StDb5kHs6w5wSySKcSaGL78hHxT0Z04R2otLLB5r9Qq6rqhwjKc0cCqoRBfq+VDuNrTJF
 q5u+E4pN8Ifz8pEwennPBe9/VxLU13Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-KJ05zuFgMYqf9byFYW2U_A-1; Wed, 17 May 2023 09:29:23 -0400
X-MC-Unique: KJ05zuFgMYqf9byFYW2U_A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bc46a14e8so765387a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684330162; x=1686922162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0HjJBZfFbalmQk+/E5s2NCc60wE7ImQMAqU0QQPPLk=;
 b=QRt8hUiHjsyW4+CVslO53QacPYv3MIo1V1AiGS+kR27SEteIh08aWim9N2afnw+wU5
 zw6URTLpJGRXRDEk/SS3+YbpJxfxDRwR5l3MOuuQtHUQzse8awp/wI5chiTJkqwzcIcw
 ZfK8a8AbeVv2/Cw5bCnZpG0cc/t3pNu5klHhzqlrSt4zxEkoMnmv70nN8BJkfHeTF9Ws
 4qASq9CljIZr9GorCRa8YDJyPxHA6ee4KwInUCTsi4OFUbqN5oZpFg0YlwzUcTJRHahP
 PH4lL/PyMj98kDFfCPTh5Y8JAcBumZf8qmeXXGnewfXVTfbVpzxpRybLulIPxvxjMEH0
 uXWA==
X-Gm-Message-State: AC+VfDxRARPSmhfHW6FWIoaOTUBdJm6eQwqcZGApzPf2pdZKfjhVp40t
 tzGGihBZ71I5rxZNfO5IRRAb9SjMbuDUvp8cSx0vsXqOX0U60xJ+uhPik9k9lnKHTWaDITp9yy6
 DE7gFq+x7LW3T83A=
X-Received: by 2002:aa7:d31a:0:b0:510:b4d0:251c with SMTP id
 p26-20020aa7d31a000000b00510b4d0251cmr1984029edq.17.1684330162611; 
 Wed, 17 May 2023 06:29:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rHh5W3BaXnG4a/1la7/0OZkCEZj1GnIvCa5MBJrqEU4PnMPAI5yqCYk5xvfm4xsBDlpvjCw==
X-Received: by 2002:aa7:d31a:0:b0:510:b4d0:251c with SMTP id
 p26-20020aa7d31a000000b00510b4d0251cmr1983999edq.17.1684330162108; 
 Wed, 17 May 2023 06:29:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 c7-20020aa7d607000000b0050bfeb15049sm9202108edr.60.2023.05.17.06.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 06:29:21 -0700 (PDT)
Date: Wed, 17 May 2023 15:29:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 richard.henderson@linaro.org
Subject: Re: [PATCH] qapi/parser: Drop two bad type hints for now
Message-ID: <20230517152920.020dfa81@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230517061600.1782455-1-armbru@redhat.com>
References: <20230517061600.1782455-1-armbru@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 17 May 2023 08:16:00 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Two type hints fail centos-stream-8-x86_64 CI.  They are actually
> broken.  Changing them to Optional[re.Match[str]] fixes them locally
> for me, but then CI fails differently.  Drop them for now.
> 
> Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Fixes build failure for me on RHEL8

Tested-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  scripts/qapi/parser.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 4923a59d60..1ff334e6a8 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -563,11 +563,11 @@ def end_comment(self) -> None:
>          self._switch_section(QAPIDoc.NullSection(self._parser))
>  
>      @staticmethod
> -    def _match_at_name_colon(string: str) -> re.Match:
> +    def _match_at_name_colon(string: str):
>          return re.match(r'@([^:]*): *', string)
>  
>      @staticmethod
> -    def _match_section_tag(string: str) -> re.Match:
> +    def _match_section_tag(string: str):
>          return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
>  
>      def _append_body_line(self, line: str) -> None:


