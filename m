Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9377E1FDD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:24:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxbj-0004ow-Bw; Mon, 06 Nov 2023 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxbc-0004S2-E0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxbZ-0007FL-85
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269435;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pyvJV09e90UdEydBUmLVRjhsoumg2Wl86mYz1QF5y/k=;
 b=ehvwtDWdheX1rZBhtvXeyordsSlkqmLMK0kVfsnYyBTNyKxkBbw7St6skCBmEX8VQLOuro
 n39h8r2yIa/H7XjnvfIqzZ20mhRNVvX0Bt/cVxgjVg7+KzJXFCBnOqCvtBh32VBe20x/47
 zGM6xBaUPBqix24f8t/xoRqP8Omayho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-sDTD16sdNq6d9NtwAbMK0w-1; Mon, 06 Nov 2023 06:17:07 -0500
X-MC-Unique: sDTD16sdNq6d9NtwAbMK0w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso27458215e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269426; x=1699874226;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyvJV09e90UdEydBUmLVRjhsoumg2Wl86mYz1QF5y/k=;
 b=Q0NahHPn9dF58OsM93p9R0uSPIRNXnroMOolvYaG+oFyqIK4dMtu/F+QoosYAaNt5X
 LVPTdQnf1/zHTYT0ZBn7W+kIjd/bz8C4tA32K9T+I3CtaNzyxFZjm0N1j57wV3qRzNsj
 9e/svRSc3oIlZuIXfdLA0lExk2Ii1YhdJzU4iBrkv8wcLMj+BYFQ5vIglVJw1A+ZSokB
 Ab5prD4WNR87BigmnVV3FUj8Eo6y3LGJrfZc9LPHZi+S7OWbmnADaTlfsbta/k90kED/
 IohlDd05N1cfXlEDp0lHazzu5fl73TsXhKiYnyXXXzqbmLstT4HhYTyc9PQkTa+jY/F1
 I3kA==
X-Gm-Message-State: AOJu0YwW4C+cB1F98h4BpnruE5G0IxNhRcQ+dL6hl7lfUCDwTzsyp/Gl
 un6ZdnLsDVs1JwkRMjWtK6tq3o2sFtvPO0qVT67C/vSpbxtwnJaTIKgoKuDtpvG1Yf19OXnNs1p
 yv+SB5NjaK3PJ7yM=
X-Received: by 2002:a05:600c:154e:b0:408:403a:34dc with SMTP id
 f14-20020a05600c154e00b00408403a34dcmr24181077wmg.37.1699269426647; 
 Mon, 06 Nov 2023 03:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj0aOJ+i94swLW19eM33Ld9HyZrRBoHAhZa2JVIuBhJNL3EfEG+eEKrph4/ASxESvnhFzNcg==
X-Received: by 2002:a05:600c:154e:b0:408:403a:34dc with SMTP id
 f14-20020a05600c154e00b00408403a34dcmr24181057wmg.37.1699269426274; 
 Mon, 06 Nov 2023 03:17:06 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4943000000b0032fb0e2087asm9209557wrs.82.2023.11.06.03.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:17:04 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 leobras@redhat.com
Subject: Re: [PATCH 01/71] migration: Make VMStateDescription.subsections const
In-Reply-To: <20231106065827.543129-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 5 Nov 2023 22:57:17 -0800")
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-2-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 06 Nov 2023 12:17:04 +0100
Message-ID: <87h6lz168f.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:
> Allow the array of pointers to itself be const.
> Propagate this through the copies of this field.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

>  static const VMStateDescription *
> -vmstate_get_subsection(const VMStateDescription **sub, char *idstr)
> +vmstate_get_subsection(const VMStateDescription * const *sub,
> +                       const char *idstr)
>  {
> -    while (sub && *sub) {
> -        if (strcmp(idstr, (*sub)->name) == 0) {
> -            return *sub;
> +    if (sub) {
> +        const VMStateDescription *s;
> +        for (s = *sub; s ; s = *++sub) {

If you have to resubmit, please consider:

        for (const VMStateDescription *s = *sub; s ; s = *++sub) {


I think it makes clearer that the variable is not used out of the for.


