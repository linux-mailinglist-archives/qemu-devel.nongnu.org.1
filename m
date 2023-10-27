Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E07D93A2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJ6M-0003ws-BO; Fri, 27 Oct 2023 05:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJ6K-0003w4-DH; Fri, 27 Oct 2023 05:25:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJ6H-0008Ev-VA; Fri, 27 Oct 2023 05:25:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso14403935e9.3; 
 Fri, 27 Oct 2023 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698398752; x=1699003552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=omznWtzf1XKHmZ/Z5NbQjoHVHixpWX6ejbkUDaU7VuQ=;
 b=IH0ZxQQGDGYoqPnwKzGr79QI4TSiucWed/KlDdN+7sK1f09d6MGFlTJSEH74dTKHNK
 XoR23hvpG6xPc7y0lceAEE4DJx1GQ8OCfUbLdngTJUIMPmuRwLsR/jZI5IApAY7Fst36
 c0X136YECvahvrnsPQWiXNvfCxs0aXVVdQ7DV33B0MN7GRE4hgTcjLFvvXEbW5z+mHlI
 8kWqr+MR97ir4UfsvFbaw557Zv7UyuPAw6UsEXwQGhuwFcA5CO5oxOif9sIyIenC+FU+
 AABT2JzEtDj7iebLwwfYq1sVpRFeDIgQXUPFLpuQeYGE557YC56bWYb+lZ8VUWo2FdmI
 za5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698398752; x=1699003552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=omznWtzf1XKHmZ/Z5NbQjoHVHixpWX6ejbkUDaU7VuQ=;
 b=XSvBiEUK5smDVtHHxoAWSo8tALi8zIAWsiLJ3xXEBB3jnRNxye7de6fpVtt9Ftr/Zc
 FD9NoOoz+SxVnxvAa++jK2+N/YmsSg8bZ8O5UusSBlhBq1yyQckWRw+hDc5aIBfkfQ3l
 9MOZO0K4Y5nIakVpTjdCbEZVQ3s3J3gI+47k0tiIjOfD9rI6liTrD2reMFUISujk6vmR
 zYz4QxEQ7jBLk3P/0ItkVBNkGDpjzrrGVhJnTNmjqi2dFNPWeFlSvysEXihoRwYzngdf
 8LT0mzKFTvWX1ULj/Eyl/7zCZmEYW1MdGxGbvtytQoT6Bot6uGjKAnHewpDTWi7u43dk
 DJEw==
X-Gm-Message-State: AOJu0YwdqTkRKBpEvqpsjpb3snVc1eZOXxylVi012pDPqScGir2Vu/XJ
 3NRPdXJbLFaX3Ycdfjd+pYdwzBneM34iSQ==
X-Google-Smtp-Source: AGHT+IHJSsP+G8xwzCbhqRxELYFim76cG7KxRmQWj9AASSXVf0gXlQDLn+wC5l6TMdiRtV9QnIFltg==
X-Received: by 2002:a05:600c:468e:b0:408:3739:68fd with SMTP id
 p14-20020a05600c468e00b00408373968fdmr1901178wmo.6.1698398751572; 
 Fri, 27 Oct 2023 02:25:51 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a05600c45cd00b004083bc9ac90sm1171371wmo.24.2023.10.27.02.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:25:51 -0700 (PDT)
Message-ID: <e4bf8f7a-9635-4315-b0e1-6dfb6c524631@gmail.com>
Date: Fri, 27 Oct 2023 10:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/28] net: add qemu_{configure,create}_nic_device(),
 qemu_find_nic_info()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-23-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-23-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Most code which directly accesses nd_table[] and nb_nics uses them for
> one of two things. Either "I have created a NIC device and I'd like a
> configuration for it", or "I will create a NIC device *if* there is a
> configuration for it".  With some variants on the theme around whether
> they actually *check* if the model specified in the configuration is
> the right one.
> 
> Provide functions which perform both of those, allowing platforms to
> be a little more consistent and as a step towards making nd_table[]
> and nb_nics private to the net code.
> 
> Also export the qemu_find_nic_info() helper, as some platforms have
> special cases they need to handle.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   include/net/net.h |  7 ++++++-
>   net/net.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


