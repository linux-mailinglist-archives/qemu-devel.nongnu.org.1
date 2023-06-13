Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1172E88A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96ui-00050q-2f; Tue, 13 Jun 2023 12:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96uf-00050f-TN
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96ue-0001vM-EK
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686673831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXcDBwY8NJQYRexlbNmv/4vosy7uqy6m/GwuKdg9TPc=;
 b=WHmcwP5dR6YvyUyFOWF/5LrqZTsooIbrzzp9AhXzZNKiUtKXPl8VFHkl7KW0ukXw9q1T4R
 HrxraK08Hv/bNBCN6lb/5z+GBCL5nEnE3GfF7L8aAL/1L5TgbPkExYHIUw4wngm1dS+ACf
 /gHQyrLXev36Hr67eU3HULetMfcGEbo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-VXb_5l51P1KC5MGpRo4SsQ-1; Tue, 13 Jun 2023 12:30:21 -0400
X-MC-Unique: VXb_5l51P1KC5MGpRo4SsQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f7f4a7b289so106778595e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686673820; x=1689265820;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXcDBwY8NJQYRexlbNmv/4vosy7uqy6m/GwuKdg9TPc=;
 b=T/UUE7z9u88GNGbVVPTc2MkIkg9xum2SsLtVEMcM/D4jE5xwoj7qYNrq1DmHeRXPrx
 DW0Ir+p3h8Pd4Skxj56CBCyUl7TmEA9kK1cYDIlL94QAkLjRjCxYqlJPGgnv8NJfErIC
 CoMa30JJOH7YyghgbVortLeLS8kQrn+0vF0Hbd1QNofc/QyqlL6o89ZL9hM6RcJoF5oa
 dBxK2VogCUkifexXmlb0lqzX5reACK8b8bE1utcehgdtFGMxU6Qc76s7e+epURA2i6S4
 RNbJqDVVpCuXOPnSWTca/B/1SIteyhuMFqidBSg1Rt9QkL6FGsjcNefOjyZr8eDuzV3G
 oZUg==
X-Gm-Message-State: AC+VfDzARYA5FvgjRHLyDmpJuGT/drMehGoDCuZtxgNFHebC1Pip8Apb
 ktNQG+kK3C7gYcj0FIP5/NnDp6e0ZzxN1W8wIrFD3b12DKRQFFxrBprSZdX1YjxVEcDKcZvZcyv
 jxjFD/DrQXulaHhw=
X-Received: by 2002:a7b:ca51:0:b0:3f8:1e00:5a62 with SMTP id
 m17-20020a7bca51000000b003f81e005a62mr4751043wml.38.1686673819853; 
 Tue, 13 Jun 2023 09:30:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pkkhaWTIua7xtolDQE71ILrvToiv49FQtdMrwXEwx16rURmXGI7RkPza6UoPTLvzuxBz6FA==
X-Received: by 2002:a7b:ca51:0:b0:3f8:1e00:5a62 with SMTP id
 m17-20020a7bca51000000b003f81e005a62mr4751021wml.38.1686673819500; 
 Tue, 13 Jun 2023 09:30:19 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f24-20020a7bcd18000000b003f8cdb1414esm2177777wmj.8.2023.06.13.09.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:30:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 3/8] qapi/migration: Introduce vcpu-dirty-limit
 parameters
In-Reply-To: <168618975839.6361.17407633874747688653-3@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 22:58:32 +0800")
References: <168618975839.6361.17407633874747688653-3@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:30:18 +0200
Message-ID: <87edmfe351.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce "vcpu-dirty-limit" migration parameter used
> to limit dirty page rate during live migration.
>
> "vcpu-dirty-limit" and "x-vcpu-dirty-limit-period" are
> two dirty-limit-related migration parameters, which can
> be set before and during live migration by qmp
> migrate-set-parameters.
>
> This two parameters are used to help implement the dirty
> page rate limit algo of migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


