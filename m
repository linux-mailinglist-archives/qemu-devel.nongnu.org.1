Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BA72E8A1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q971o-0007mW-Jo; Tue, 13 Jun 2023 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q971j-0007m8-I1
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q971i-0003eX-31
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686674269;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHhg4Vkj3kzmTs9I/obrM8poeyuVK0zEqvr28mPzJgc=;
 b=PN/eL55fT8tseblK2fdNUFvRQRjrctIjqWBmwVDZz8HedIGw48r9lWOFCNG2McJ8ivG3+o
 wHN+FZNoSDwFhKi50hxos2QQ5Hlaj5H8dtjlgzkNkPLbdBvRIXHfaTtWzixi/fesVPg7PN
 NZ0YkHF+AMap970NsMHlKwITNpU55Tw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-d5a1jjzgNcCnQvZ707y8_A-1; Tue, 13 Jun 2023 12:37:47 -0400
X-MC-Unique: d5a1jjzgNcCnQvZ707y8_A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1abdb8ef9so50048571fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686674266; x=1689266266;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHhg4Vkj3kzmTs9I/obrM8poeyuVK0zEqvr28mPzJgc=;
 b=M65bBceP6lBGs/tlLtgi6P5fRlrRTFEyKZVKUsPOxniRBZ0y8BTVrN4iyD9XxSmucw
 vUiSN8ruZk6WN5/eNj/KubojIjdCA6d9NYldhvROWS9vFhHXUctkpV0PtAVOOcpj2zyG
 Ym7Yr1xodfxm5UwfpTeXign7wFhuJwZV3546VXgyZAQay3vobFx65oRocD95q7RgW6Ho
 VQNx6Z/C9RWiCc5QheIsFJMlqPrZPa8Oz9rGtyiVMV9wbHpOYCKJeLQO8+HkJSKRnt3d
 znS5DEQZVaqYJeWnksMuFwfPhnLu4EHSz4sxvA/V21hlR7GgcoNyxE6cYtsChkU2M/ZU
 2IuQ==
X-Gm-Message-State: AC+VfDw4kzjVbyN+/XV4NJBBIoSwNe2Y95MHfanUmmGxS4FaYB2wd8vc
 Udjc6M7KqE8AUQAXM9cyZX+ivzh+pDw2lTa8/n9dOq2Pz0mHKwzOd0sPMMeuGHveNzqQsFXsGLn
 OVx7G1eA9G0s6NJQ=
X-Received: by 2002:ac2:46ec:0:b0:4f3:a820:dd98 with SMTP id
 q12-20020ac246ec000000b004f3a820dd98mr6602571lfo.7.1686674266278; 
 Tue, 13 Jun 2023 09:37:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NPKIko6LyX5Q/esxqGgf5/STwy3e8/etuETHQ62LAg7wXR5OWjlPJuIt1ixtfPqStxLWs8w==
X-Received: by 2002:ac2:46ec:0:b0:4f3:a820:dd98 with SMTP id
 q12-20020ac246ec000000b004f3a820dd98mr6602551lfo.7.1686674265946; 
 Tue, 13 Jun 2023 09:37:45 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d43d2000000b0030ae93bd196sm15778122wrr.21.2023.06.13.09.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:37:45 -0700 (PDT)
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
In-Reply-To: <87ilbre3kv.fsf@secure.mitica> (Juan Quintela's message of "Tue, 
 13 Jun 2023 18:20:48 +0200")
References: <168618975839.6361.17407633874747688653-1@git.sr.ht>
 <87ilbre3kv.fsf@secure.mitica>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:37:44 +0200
Message-ID: <87y1knco87.fsf@secure.mitica>
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

Juan Quintela <quintela@redhat.com> wrote:
> ~hyman <hyman@git.sr.ht> wrote:
>> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>>
>> dirty_rate paraemter of hmp command "set_vcpu_dirty_limit" is invalid
>> if less than 0, so add parameter check for it.
>
> why?

And here I am, making a full of myself.

vcpu_dirty_limit and vcpu_dirty_limit_period are two different things.

So:

Reviewed-by: Juan Quintela <quintela@redhat.com>


> Next patch does it correctly:
>
> +    if (params->has_x_vcpu_dirty_limit_period &&
> +        (params->x_vcpu_dirty_limit_period < 1 ||
> +         params->x_vcpu_dirty_limit_period > 1000)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "x-vcpu-dirty-limit-period",
> +                   "a value between 1 and 1000");
> +        return false;
> +    }
> +
>      return true;
>  }
>
> I hate to have to search several places to check for errors in values.
> We get all errors in the functions that set the parameters.
>
> Can you resend with just the monitor command removed?
>
> Or there is any advantage of getting the error message from
> qemu_set_vcpu_dirty_limit()?
>
> Later, Juan.


