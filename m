Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E77B88AF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6Pv-0007MM-O4; Wed, 04 Oct 2023 14:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Ph-0007B9-77
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Pc-00086c-2V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696443355;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3vfV70nt6Z476QmDhBufxf1KpaFQSxr161KBGLmeVY=;
 b=aiDDQZBd5udjGcSMXDIW783Rtc3CcEWrwC5yU2T09W0qxUSUGOksl2JLnJCyLL3jyMKTxu
 e9I+kEkyJzsS4zCfEg0IGF1YWaQhDeadFKYWQ9tb4Wt09uwAAx80TCMPSLuLrF9SjGhh+F
 kKnNSSpsmBlQpaXEPP4HtUnpEU+D6fk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-b2ugnbeMNu-Gd4Iu6PFvdg-1; Wed, 04 Oct 2023 14:15:44 -0400
X-MC-Unique: b2ugnbeMNu-Gd4Iu6PFvdg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so137763f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443343; x=1697048143;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L3vfV70nt6Z476QmDhBufxf1KpaFQSxr161KBGLmeVY=;
 b=ciEe+OIG/LJ59hAdY8zvKm9MPl7VJN/V1CAXiYliKwJfJakJAeRxqXnj2QA/BoVtxO
 zZ0Id+pimW3A6KKdhpkFBbxLBOVl9l2T9vYQEgBFJdSebbT9h1Umo6o0Reg7wBgNfQVo
 1KlFyUh4XMFTDzLJHs2oi8Nx1NTfqoC7L/eyclEnEQ2dcmEX6wyuDbd1rTG2crFjwgnC
 nKnWNcAPt5ThwQ9K8YuZE30V8EaSzR8VbPzjkX9mJ/YD7aVwZz82Sdh5+YmmuKWsDkvj
 0JnskK1YOUR4mymdmR/OsFIfxbfpNFM1spKHTwfk8Oj393TqImgANk5tD1prMEIbwa0A
 fS1w==
X-Gm-Message-State: AOJu0YwIdMttEZLdYBpYmX2NPDCTu1G9WuY/i8rECfMi+g8HFcvLU6+6
 c2HQAtnt9XsYoAMiF8CgagXMkZO53W+W3KmWFZQpiorDLkqFZAVMcPROAmPXgmc6jV3LIea22Qa
 fc2o+94COZxb+24Y=
X-Received: by 2002:adf:d4cb:0:b0:31f:d95d:20a6 with SMTP id
 w11-20020adfd4cb000000b0031fd95d20a6mr2789029wrk.12.1696443342917; 
 Wed, 04 Oct 2023 11:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEivlBGDqrXK9uOz+2ihhml6MoqGMDtgy/eHWt+59SwRDpZlOHxq/AhY4P+VS7PRWsX4tvB0Q==
X-Received: by 2002:adf:d4cb:0:b0:31f:d95d:20a6 with SMTP id
 w11-20020adfd4cb000000b0031fd95d20a6mr2789012wrk.12.1696443342583; 
 Wed, 04 Oct 2023 11:15:42 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b00326f5d0ce0asm4536916wrx.21.2023.10.04.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:15:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 14/21] qapi: Inline and remove QERR_MIGRATION_ACTIVE
 definition
In-Reply-To: <20231004173158.42591-15-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 19:31:49
 +0200")
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-15-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:15:41 +0200
Message-ID: <87sf6qqmnm.fsf@secure.mitica>
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
> Mechanical transformation using sed, manually
> removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


