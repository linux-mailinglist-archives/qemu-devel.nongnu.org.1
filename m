Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2771F635
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4r2I-00030P-44; Thu, 01 Jun 2023 18:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r2G-00030E-0o
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4r2E-0004mD-8C
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685659484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jc04JwOcYUYFYAxSv8FLw8U1u0UtKW0VZP/y2Rd3hBM=;
 b=BQgwYBQw1nKzPDoo/lbAw1NzeRVVX4acTPXvDLPyyln+Zwfh7klTlxv+Fy1IsUQdCGXTlz
 ZD076JjER1j8OzzDOPEzLddLGzTHqPn5HVgurw/3Mp+RY2mAOM7zb9wZqix8d97ASTLjdS
 LGfkhrpBGBKYwzGLr89skgmE4sDLpRk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-8TonzdySNQyyEXj05r_0Sg-1; Thu, 01 Jun 2023 18:44:43 -0400
X-MC-Unique: 8TonzdySNQyyEXj05r_0Sg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so1661973f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685659482; x=1688251482;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jc04JwOcYUYFYAxSv8FLw8U1u0UtKW0VZP/y2Rd3hBM=;
 b=UGwYZd5a2i0D5mXOgz1uNjh2U6EqH26B9LFn29viYdgdLtC7KZbI3aOd7uChiGSyGn
 rR6rUQIdplZNBZwvajIOXjhm+yC5LS7wgBdj2On7IKwvash2S493NOpf6M7b7y662uLe
 yH87bSlkgGKTKLcGBLI+N3BF/JR9NSE3CgYc5gotspSSkBTPriEBSzqtA3v9lWC/la3a
 +OINL5IJffh6eeiUcgRV3hdc/VIwwsJbIBfB0sDm5/iSJnC37j2BitDfF6Ct5MaZUGKR
 v3akZadJ9xfyJ79xo7iYAstuWvh+xUp0R9n+aN/CgvYbvVqW1yKAAl4QtcQvlpp9SFwM
 29+g==
X-Gm-Message-State: AC+VfDzv+a8rcXRJxDitGHYAn+uwFrNe3Y12JsRe+b2b0LFkOg21mSa1
 Ru774+W9xUhxEE7cvJ2zbsJO7Zwq6aRdwiAW9NmG/3PtHJxQn6MQGlnyXNdNPfqxVpK5Do7rswp
 CscvMjpLKyfR7jok=
X-Received: by 2002:a5d:6747:0:b0:30a:a715:66c8 with SMTP id
 l7-20020a5d6747000000b0030aa71566c8mr3255337wrw.8.1685659481958; 
 Thu, 01 Jun 2023 15:44:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LZ3aVMWyoCZnl1bZzL+A86BO9S2+7TjR9zYZjbcZJAz6SVunVv0Zys+V+wUpW/bxSKRWkxg==
X-Received: by 2002:a5d:6747:0:b0:30a:a715:66c8 with SMTP id
 l7-20020a5d6747000000b0030aa71566c8mr3255323wrw.8.1685659481569; 
 Thu, 01 Jun 2023 15:44:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d66d0000000b0030ae6432504sm11454135wrw.38.2023.06.01.15.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:44:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 01/10] tests/qtest: add various
 qtest_qmp_assert_success() variants
In-Reply-To: <20230601161347.1803440-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Jun 2023 17:13:38
 +0100")
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-2-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:44:39 +0200
Message-ID: <87wn0mreeg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Add several counterparts of qtest_qmp_assert_success() that can
>
>  * Use va_list instead of ...
>  * Accept a list of FDs to send
>  * Return the response data
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


