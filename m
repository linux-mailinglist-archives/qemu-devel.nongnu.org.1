Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A257F969D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:47:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Opu-0007er-Ty; Sun, 26 Nov 2023 18:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Opt-0007eW-8i
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Opr-00030X-8f
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02LKGz5VoGfr9yBKlb+J5KTlyaLOTpS3Dy3xhbCLpE0=;
 b=fI2Hj3U/pZ5Z3kf/Ao8Thp7ofFOVcg9MclerAeO1fxtR/mDvUbGgJmRcsBtGhEGO/bZQjT
 fxOSgWTCgSpJGdi7qVRkAIb1fYVy7GWvEA9mCi7ytyV49shFzaQ1ix8hZem1Y71CIKf40n
 p3aoBs6XFRqeQZTcgUMVg3faZzK4awM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-h0POslNPOiibr_BjzEq69g-1; Sun, 26 Nov 2023 18:46:44 -0500
X-MC-Unique: h0POslNPOiibr_BjzEq69g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6cc01c9d96dso1723577b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042403; x=1701647203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02LKGz5VoGfr9yBKlb+J5KTlyaLOTpS3Dy3xhbCLpE0=;
 b=HFi9GiTo3WqX6Sck7EfqTAZ6F8EzqWLwFcv/q8uDZX4jskvKlUuJfV7R1Sc3RmjupP
 zDS6uD6bwLIGKGIwHLstGNgL+STwc16oG2svX5FCvVIjsw5ajBsJ5v0MgMKbhteGeZ3r
 j56n3yRiJR9pS5zWToE63HwIw8kv1I+hU7NtgnVgALwAoXaiAqpsZu0Gri0mrwRXxY4S
 L/HgYCXFItWzhAz8W3XHSASinYrLjeEAPkxw9qElDqPvt4hc1K2DdYA6FCf9CoGJIQCK
 26cg0eqebIk+d+STTQh/RKTW46EJZFgOJUu4RALORAfvq7Vfh4M0/UnNl5GyL6JAZaem
 SZ6A==
X-Gm-Message-State: AOJu0Yzohu8AQFrhJGt8ewEgyEoJ5JOK7qOFm+rCIRYNAO5ircKNDf4n
 pCKLolXW4Q8wvSsRfGOI/95V3+XxD7QGfzY1kuHPhzXXVrDm5Rd4uXUfK2AP+9Vr2tSfLDgGJj+
 to8+YHi7IQtBYq3g=
X-Received: by 2002:a05:6a00:2410:b0:6b4:c21c:8b56 with SMTP id
 z16-20020a056a00241000b006b4c21c8b56mr9532941pfh.23.1701042403683; 
 Sun, 26 Nov 2023 15:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVj4A0nJL+0wrvuuaq0oTMB5SijDPXA0+Cq6+klut5TdCEcX3qcPH4w0ZFm4JN0UvgamodyQ==
X-Received: by 2002:a05:6a00:2410:b0:6b4:c21c:8b56 with SMTP id
 z16-20020a056a00241000b006b4c21c8b56mr9532931pfh.23.1701042403384; 
 Sun, 26 Nov 2023 15:46:43 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a056a00194c00b006c4d4d5a197sm6199877pfk.171.2023.11.26.15.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:46:43 -0800 (PST)
Message-ID: <fc993a45-69ba-4abd-8291-4fb701f662a2@redhat.com>
Date: Mon, 27 Nov 2023 10:46:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] target/arm/kvm: Move
 kvm_arm_verify_ext_dabt_pending and unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-5-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 10 --------
>   target/arm/kvm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c   | 49 -------------------------------------
>   3 files changed, 57 insertions(+), 59 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


