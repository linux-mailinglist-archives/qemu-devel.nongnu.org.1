Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D39711615
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2G4G-0008Sc-V1; Thu, 25 May 2023 14:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2G4E-0008RI-0t
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2G4C-0006iI-JL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685040723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+LK+jkhH0gDGs9MdxVNYT3jo/1ssY6oLDqNoxiT5wK4=;
 b=bYi8zyOhnTp4iR9JFq+qq/Gw8sn+o4vZRp80GICegMP4v7Rx88uo+EDpEhzhBfYSIWKvfr
 k6ALW9Ewlzgy+2YOtzTsF44KtyEpRlA/Ru1xMy6vUSZZFsflaPvtKi9VMnNptGTT097Ot5
 oA/fZnXHaHto7Jn4PmcjymNadkVHbrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532--KwKV8oRMbGAOtPZJIDGzA-1; Thu, 25 May 2023 14:52:01 -0400
X-MC-Unique: -KwKV8oRMbGAOtPZJIDGzA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso1138654f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685040720; x=1687632720;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LK+jkhH0gDGs9MdxVNYT3jo/1ssY6oLDqNoxiT5wK4=;
 b=OWo76ZFZAa3E83AuGmals0RJyq8uW7q4Lw+xLSsF0R6VThFPFMyi17IE0YGLQTNspJ
 A1KqkNwm0OO+M5xDhgCd6QFmMfWnOYed9czRwZcmumYsN6xUpTv6SBcolEjek9EdeI43
 lqnvtXOJQA1++LcQ8m2Lg6uHiX70kuJz0lD786G5XePEUqM07WgG333R+bBNq56gBkzx
 //oRpqli1Bqnnw8UlpRw66DzK5grfLJRvS/dmyyVEIej6puEN0uGwDcbMgqdqYaY/ubh
 nGeCj6WAh7E1c4ZiUJDbmsenh8VWx7LoMnAZ/SdI3VFqz77CABci+6LgHgfCJzYu0+IL
 +iMQ==
X-Gm-Message-State: AC+VfDz1UDIFmmbFUbQLgCdRmSbelNce43KIdNAutXjiWPw/48fR0/Kp
 M7bC/jfTCYvLqbZRqupWQ95ACCSlM2wyRy32TrWuNPdpzeU1j0+WO1zu0hGvuSMgyOkDjHJ3/hS
 va+ayMYU6EyxubdM=
X-Received: by 2002:a5d:49c4:0:b0:30a:8c0b:31ff with SMTP id
 t4-20020a5d49c4000000b0030a8c0b31ffmr2513384wrs.10.1685040720745; 
 Thu, 25 May 2023 11:52:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TKxFg+56qi9oqTVDNNbCl7IbxmxjSn2Vq9Ncrfs40414qIdhdDZgfBXOYr2UxqMYZxkUlzA==
X-Received: by 2002:a5d:49c4:0:b0:30a:8c0b:31ff with SMTP id
 t4-20020a5d49c4000000b0030a8c0b31ffmr2513378wrs.10.1685040720473; 
 Thu, 25 May 2023 11:52:00 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l6-20020adff486000000b003047f7a7ad1sm2641358wro.71.2023.05.25.11.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:51:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] configure: unset harmful environment variables
In-Reply-To: <20230525154718.355734-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 25 May 2023 17:47:18 +0200")
References: <20230525154718.355734-1-pbonzini@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 25 May 2023 20:51:58 +0200
Message-ID: <87mt1s452p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> wrote:
> Apart from CLICOLOR_FORCE and GREP_OPTIONS, there are other variables
> that are listed in the Autoconf manual.  While Autoconf neutralizes them
> very early, and assumes it does not (yet) run in a shell that has "unset",
> QEMU assumes that the user invoked configure under a POSIX shell, and
> therefore can simply use "unset" to clear them.
>
> CDPATH is particularly nasty because it messes up "cd ... && pwd".

It is weird that nobody noticed it.  I have been using that CDPATH since
last century.  Yeap, that makes me definitely old.

> Reported-by: Juan Quintela <quintela@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Juan Quintela <quintela@redhat.com>

Thanks very much.


