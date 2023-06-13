Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077172E84E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96lP-0003IE-U1; Tue, 13 Jun 2023 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96lM-0003Hv-NF
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96lL-00085x-BM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686673254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XXxddwC+wU+7JKutbiPVl229gREkDMJxuML10uV03Q=;
 b=Tx4Eo1Q/dmO2K9aJKgEOwYJE/Y5QDNQayVucOlP12SC0e03t/37hYuPKu5HxDRzkcTRwmr
 +BBCvy5Dz4NAPB+YKatAy0S1FnVmXafh6vJEksdaFJ0OyAkdvqLtXUxObvAgo83yhNIU7d
 IlKYbHL15yLeP51gsZnh5AwLVXSd+5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-xHuri3qMNbmPkQICcc9Chw-1; Tue, 13 Jun 2023 12:20:51 -0400
X-MC-Unique: xHuri3qMNbmPkQICcc9Chw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7e64e1157so36911545e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686673249; x=1689265249;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XXxddwC+wU+7JKutbiPVl229gREkDMJxuML10uV03Q=;
 b=abXKeDhIi5Hfs6532lw8e+jE3OZakDt/hiNh+PAXMgOR5cPH6jGfXWfYy6powpxTMk
 XBseHG+8TSSODX7fbgLlzMNwDSEoDbiobTO+sRCG2IhaEo30iOOhudhb/lzxEtlU2/GP
 DIh5GyJ+fAO1O57280YN+W0QPs1HfsRF3JPqXGdbKMm2s0hhkLG47Iwmi9SSuRPcjxET
 vlmK/aywM0H6Cylp6OUaUgPmzWisvj8LgLlaglKQ5wNBnjoUKnqdIbu/rW834x5/k8uH
 efaKM5iG6kiehzIOCdtkShpNPZcxPyFtQBCBwkLgAm7wbtiijRj0wx5yVlIsONsZvsmb
 e3lA==
X-Gm-Message-State: AC+VfDw1tlKeFVp3Hr+LzAdJ/EECTVFYP+F9konymGfLjsHfiyaIJ8RB
 ZUccehgruccIYd+wjPPQX5niDHJVsU5Cl3+flJATcD58/dvuiU/bOA3NjQm7m4McJrUSkssupIw
 +qWpyHQ6HtV2XUYA=
X-Received: by 2002:a7b:c349:0:b0:3f7:408e:b89b with SMTP id
 l9-20020a7bc349000000b003f7408eb89bmr10338231wmj.33.1686673249616; 
 Tue, 13 Jun 2023 09:20:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DeSsTXctx/nJeDdAEVoa1tM/UAm/Wn9Dqo0YVjE6PQ4bG5KFi7VKIOQO5Q191jnJACoh0Eg==
X-Received: by 2002:a7b:c349:0:b0:3f7:408e:b89b with SMTP id
 l9-20020a7bc349000000b003f7408eb89bmr10338220wmj.33.1686673249347; 
 Tue, 13 Jun 2023 09:20:49 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u13-20020adfeb4d000000b00301a351a8d6sm15772962wrn.84.2023.06.13.09.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:20:48 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 1/8] softmmu/dirtylimit: Add parameter check for
 hmp "set_vcpu_dirty_limit"
In-Reply-To: <168618975839.6361.17407633874747688653-1@git.sr.ht>
 (hyman@git.sr.ht's message of "Fri, 18 Nov 2022 10:08:54 +0800")
References: <168618975839.6361.17407633874747688653-1@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:20:48 +0200
Message-ID: <87ilbre3kv.fsf@secure.mitica>
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

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> dirty_rate paraemter of hmp command "set_vcpu_dirty_limit" is invalid
> if less than 0, so add parameter check for it.

why?

Next patch does it correctly:

+    if (params->has_x_vcpu_dirty_limit_period &&
+        (params->x_vcpu_dirty_limit_period < 1 ||
+         params->x_vcpu_dirty_limit_period > 1000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "x-vcpu-dirty-limit-period",
+                   "a value between 1 and 1000");
+        return false;
+    }
+
     return true;
 }

I hate to have to search several places to check for errors in values.
We get all errors in the functions that set the parameters.

Can you resend with just the monitor command removed?

Or there is any advantage of getting the error message from
qemu_set_vcpu_dirty_limit()?

Later, Juan.


