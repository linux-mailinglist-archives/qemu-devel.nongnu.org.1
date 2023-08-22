Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C297847F5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUWs-0000ZC-Hq; Tue, 22 Aug 2023 12:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qYUWp-0000Yo-TJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qYUWn-0007Pq-Dl
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692722807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoTWavmSPmOPiJrvFAKyD6HqluY4SJkiX94rZhYgE5Y=;
 b=VNdMW+cPQxwMuABzzA/4hGdTmAhJDJiY+9Q8wuBE49sr6hyde1dN3lvyPBT/JUZpanoNeB
 Q0bgZlfn25tS9epPNKGeNb8syH9gV3aDmf7cSemsvCj9DfEjSlA65Bq71Bv8B3usKiSmvg
 pLAiKmUTedMSmVIJeL+/yEVqh37HuZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-_w17DlEvOUW0lumiFZxNhA-1; Tue, 22 Aug 2023 12:46:45 -0400
X-MC-Unique: _w17DlEvOUW0lumiFZxNhA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso30946085e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692722804; x=1693327604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AoTWavmSPmOPiJrvFAKyD6HqluY4SJkiX94rZhYgE5Y=;
 b=c3FQuZ1QGdwwaJuamrtyH4PLg01UZNNINBqarbhXiUzMFMLf+CnSoQ/q73S3vzhYhi
 hFPHnQdLsOIEL98pv2iya3O+r7vUbM12fmf/z9zLj4rlzbkjTipKIEFncFh62tat0Hx4
 TfL8AyoXrBka8nV7nTo4GjHj24I5RcZeJYuSq+a5RJdkEqLK3LSybB9rqAESCgX+4+Lm
 jiSDOD++xziT636sNPnBkQEGX16XuPEyB4FXlzhcD+CE1nEIJqJSBm7OHglLCzuGKbkp
 QVl+SsrhT2qX64DpWfsCerYytvSF/Vuu19TY3n1Yxg4VpfmjVTw+hcceBHzwZIzkikqZ
 tIFA==
X-Gm-Message-State: AOJu0YzIF2W1F+fG1Wo8gK7UWMPa1dmuwm6a7qwAbVv4HYcj55lkMdsD
 A7HQzErLNm6sdg4afsk8oK3qDsipBVTUezaEATODROokH2AfUm29mnhFuaCNYyOBOOpjUOQZ5G4
 WvwRWi+TZsUURb2A=
X-Received: by 2002:a1c:7302:0:b0:3fe:1af6:6542 with SMTP id
 d2-20020a1c7302000000b003fe1af66542mr7718250wmb.33.1692722804596; 
 Tue, 22 Aug 2023 09:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9WFgVO3ljbxwy2uYSEOBrWom9LCGqyNoMqouHXI4cZTR9YB/7kxtNqP6q7VsblYaI3735gA==
X-Received: by 2002:a1c:7302:0:b0:3fe:1af6:6542 with SMTP id
 d2-20020a1c7302000000b003fe1af66542mr7718234wmb.33.1692722804263; 
 Tue, 22 Aug 2023 09:46:44 -0700 (PDT)
Received: from [10.202.147.30] (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1ced17000000b003fe2de3f94fsm16198767wmh.12.2023.08.22.09.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:46:43 -0700 (PDT)
Message-ID: <9fcbcece-97cc-bf84-180a-95d4b097dcd9@redhat.com>
Date: Tue, 22 Aug 2023 18:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] vhost-user-gpu: support dmabuf modifiers
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com
References: <20230714153900.475857-1-ernunes@redhat.com>
 <CAJ+F1C+3SGHOwCsZt7nTY8_4EVD4j8M7cA1Sc=Dh_-qYn_DVkw@mail.gmail.com>
Content-Language: en-US
From: Erico Nunes <ernunes@redhat.com>
In-Reply-To: <CAJ+F1C+3SGHOwCsZt7nTY8_4EVD4j8M7cA1Sc=Dh_-qYn_DVkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 14/07/2023 22:03, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 14, 2023 at 7:42 PM Erico Nunes <ernunes@redhat.com
> <mailto:ernunes@redhat.com>> wrote:
> 
>     virglrenderer recently added virgl_renderer_resource_get_info_ext as a
>     new api, which gets resource information, including dmabuf modifiers.
>     https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1024 <https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1024>
> 
>     We have to support dmabuf modifiers since the driver may choose to
>     allocate buffers with these modifiers to improve performance, and
>     importing buffers without modifiers information may result in completely
>     broken rendering.
> 
>     Currently trying to use vhost-user-gpu for rendering backend and using
>     the qemu dbus ui as a ui backend results in a broken framebuffer with
>     Intel GPUs as the buffer is allocated with a modifier. With this
>     patchset, that is fixed.
> 
> 
>     It is tricky to support since it requires to keep compatibility at the
>     same time with:
>     (1) build against older virglrenderer which do not provide
>     virgl_renderer_resource_get_info_ext;
>     (2) runtime between frontend (qemu) and backend (vhost-user-gpu) due to
>     increased size and a new field in the VHOST_USER_GPU_DMABUF_SCANOUT
>     message.
> 
>     I tried to reach a compromise here by not defining a completely new
>     message and duplicate VHOST_USER_GPU_DMABUF_SCANOUT but it still feels
>     like a bit of a hack, so I appreciate feedback if there is a better way
>     (or naming) to handle it.
> 
> 
> looks fine to me, we may consider this as a fix for 8.1 imho
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
> <mailto:marcandre.lureau@redhat.com>>
Just making sure this one didn't fall through the cracks; should I do
something about this series or is it set to be in an upcoming merge?

Thanks

Erico


