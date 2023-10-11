Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC887C56C0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:26:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa9V-0008AE-A6; Wed, 11 Oct 2023 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa9I-00088c-MK
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa9F-0002w5-KQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034315;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ULZ5Pn6z6a9qLzDy3ML5TDgj5opbvR4H9Ta3cHWcXhE=;
 b=GuyLAa/EkQ/2VibCsDMJv2OObkyuhCtmcdAYDXnKuzfQ/8Fojs6JuSLwqad+Yyzf4OJEjg
 I2qxK/gCHt11MgB3zpmQ0tic1VgmLPdT2QHjKlUp/J+rnBsTxPyCwpPFHT37/1Ve2loM9a
 Af9a2/uZS3hhpa98qFLTSZwMLwoEbWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hSu2OS3VMr6sgGYK1lCeAQ-1; Wed, 11 Oct 2023 10:25:13 -0400
X-MC-Unique: hSu2OS3VMr6sgGYK1lCeAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40570ccc497so51596275e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034313; x=1697639113;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULZ5Pn6z6a9qLzDy3ML5TDgj5opbvR4H9Ta3cHWcXhE=;
 b=kAu9OO6DmLpBPtzwzZzaCxX1pfQk+nL2EhTycZPKkuiWR0R5Q61P7bfG8v/8bUr6D+
 lcMXQs7Ppe60uGIHvQ59aw5LiNQb3x702jg9mCp6Sb2k28B6btNcTvHWVo59f9e0xm3j
 CLRarcx6LcYmvwit309WT42AspOAhEbQr+CLTPn/AowN3qIkqWfIYBj/7rT6SJlWrC36
 pTL3nyIxk2oIAOfU5H8lsRb9yVl2crd9jDwv2JHh/NPemqMyQ4W3up1XkSKFpd3c9L83
 fXdRw3PbVYOkoIL3U4/gwj5plXxTJy/NqC0AotFHz0gOqrQhdRe7xOpgF2gyJNLaTFpN
 UXLw==
X-Gm-Message-State: AOJu0Yy5kvs0tF/Z3uaKidvMLwqxXAkAw5XoUn6VhADX/knF0WcUFewA
 DOOoqPIlIT/zrn4AoA6Wx3QPsFyG0U3Kfs53V9DKzp2iGyyMcBNjXegoNO6ljA+URPA404ZQQmC
 jtgJv6JFc7paCsbY=
X-Received: by 2002:a1c:7218:0:b0:406:81e9:ad0c with SMTP id
 n24-20020a1c7218000000b0040681e9ad0cmr19731947wmc.41.1697034312864; 
 Wed, 11 Oct 2023 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKXaHhXTf/gRablBi4B7u21Uq3G634/96lc3dk1t4VLYuCyz1wuVcTyW7knENuLemHHRUniA==
X-Received: by 2002:a1c:7218:0:b0:406:81e9:ad0c with SMTP id
 n24-20020a1c7218000000b0040681e9ad0cmr19731926wmc.41.1697034312501; 
 Wed, 11 Oct 2023 07:25:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00405935b417asm19233717wmf.2.2023.10.11.07.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:25:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/9] tests/qtest/migration: Introduce
 find_common_machine_version
In-Reply-To: <20231006123910.17759-7-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:07 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-7-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:25:11 +0200
Message-ID: <87lec98ce0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> wrote:
> When using two different QEMU binaries for migration testing, we'll
> need to find what is the machine version that will work with both
> binaries. Add a helper for that.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As it should never fails.

> +    if (qtest_has_machine_with_env(var1, type2)) {
> +        return g_strdup(type2);
> +    }

But if it ever fails, printing here an error message with the contents
of mtype, var1 and var2 sounds like a good idea.

> +    g_assert_not_reached();


