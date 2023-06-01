Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09071F649
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r9k-0007JZ-Ju; Thu, 01 Jun 2023 18:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r9i-0007JM-Uy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r9h-0006Sl-EW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685659948;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qxn32C2pe769dYjSeIsOBM4MVx3lPy71PFCesZnrwo=;
 b=S5B2QBv2ynRSecCAHSHgdjFiZ9fL5drU6nnjJo4+zN0d7n7EF+A5MLZ98VRcAHTYRayPXH
 IQUMJySNwDvu3h2Rx6W8C41Z3l7KZYA/DO+VTNspc+CeTil2+Tg3xwgNOyqdcnJtI65MKW
 jfFUjFsOEtnRPVqeB8FRSxKnYXVNV7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-dIBh0OnMP86qzvX-UYJw2Q-1; Thu, 01 Jun 2023 18:52:27 -0400
X-MC-Unique: dIBh0OnMP86qzvX-UYJw2Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30c3ad3238bso640309f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685659946; x=1688251946;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qxn32C2pe769dYjSeIsOBM4MVx3lPy71PFCesZnrwo=;
 b=jhVOkqA2WUg1j7Is5xwLir9qPiUx6avoDg9Ml1gAFM21KobtGSP9SQ3n14MNHFQ/xj
 TuAvns5QxC0iTfCvHFxR+lc/reQtNcJqMK8U+Pu2YYdEBQZX38evspHHhDPOC9IrBigL
 mtE5aW84Ex1HRKbbMqPzHIgQQNEwy/VBn5GntdkqAgw8AVs8O5i1Q7qeLkqJ1NTUMF5h
 0so3NQoBnJvTVK57igDUox+VsU2oayL9hnzPQ/wuqc0c4OCcJdooswNP3s5XX7wuUKUY
 7R6hi4rERYrEJQFah8ZfnfPTTcAzZkZWtMQfNOwiSOLq8CUdDGqKBp1QwqE+8ilZtHon
 L4gg==
X-Gm-Message-State: AC+VfDwovILP/XZF7TDNm9TNyFNlozsYhhczeeHuqZA8jAwK9O4CIsvu
 ze95pSRtb6uaZAZlHK/Y1L0R84SDkGuTaQ3Dm6cS0aD2g3V11WwdTX7M+VNLDRcQBFAx8bfi1W6
 gem6td2lAQJnzcxc=
X-Received: by 2002:a5d:62d1:0:b0:309:3698:8006 with SMTP id
 o17-20020a5d62d1000000b0030936988006mr2911932wrv.34.1685659946395; 
 Thu, 01 Jun 2023 15:52:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UtA97pNHR5Gyp4N9xPzYbpFGnlCGg6tYtk5kea07GxpwjcJz4Yz1bUHtvvnX76+H1HLtK/A==
X-Received: by 2002:a5d:62d1:0:b0:309:3698:8006 with SMTP id
 o17-20020a5d62d1000000b0030936988006mr2911926wrv.34.1685659946146; 
 Thu, 01 Jun 2023 15:52:26 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 r7-20020a5d4e47000000b00307c46f4f08sm11592607wrt.79.2023.06.01.15.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:52:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] qtest/migration: Document live=true cases
In-Reply-To: <20230601172935.175726-1-peterx@redhat.com> (Peter Xu's message
 of "Thu, 1 Jun 2023 13:29:35 -0400")
References: <20230601172935.175726-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:52:23 +0200
Message-ID: <87fs7are1k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> Document every single live=3Dtrue use cases on why it should be done in t=
he
> live manner.  Also document on the parameter so new precopy cases should
> always use live=3Doff unless with explicit reasonings.
>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


