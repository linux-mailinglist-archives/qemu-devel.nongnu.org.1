Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA2835D64
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:56:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRq4v-0003ig-Kp; Mon, 22 Jan 2024 03:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRq4r-0003iL-Ed
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:54:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRq4p-0000A6-89
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705913682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=62bZ6YzEgsMAmVBxSA/3x32NSWgifryur7uQ48c8/6E=;
 b=GlJPmmLETfklg5DZnteFuO8KgaplqeP4gD3sPyG4vZiZQ5KdlDCQYBE95kdmv2AWCl5la6
 e7L6RwMVzCnH8vLbcy1HGDOBbsOLZytuF4HZ7g2dFlpmcxUUVjWmeUqEYLqho+NskfAcuZ
 zZ+Yf68DzQkB2dXeT3AlBtlWPjVL2ns=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-DYYXJDowPpGifSmNutzAIw-1; Mon, 22 Jan 2024 03:54:39 -0500
X-MC-Unique: DYYXJDowPpGifSmNutzAIw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc3645c083aso299568276.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705913679; x=1706518479;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62bZ6YzEgsMAmVBxSA/3x32NSWgifryur7uQ48c8/6E=;
 b=HXEfAgcP5sfC1yNMAkSy4DoS1Eh88HVUV8eSn0vVzfFxjx+WfbyRNtYaPjLWJ8cLa0
 oJfulq7BVZnUMGt/ltL1V4vC8Ge8AWJrOsvnk1meHSjeFuChG9LKRNOsaKDV2EKpP2/f
 WlOlMRgvZZRgkNKpqKKGh/nA9sdLdi6DLQghb4vpJJ7/7uPL1gZ4ubFayV/H8FNKfF9h
 GOCPFVv8wDEPcJdDircFyMYSH6Yf6b2fedt4SDjgOvBRsrp7XOoDBnPWRQNBGjSMQ23M
 HHu/q1mqCI4xRjtQ1WR0cVw4Ex+vILS1iNgmJnvzvJdvmtUNX3k1fCzF/0jzVHoqC8TK
 Sfrg==
X-Gm-Message-State: AOJu0YyiVKPJvFS79IZEp2WwP/fjAyZF22W078nop+AhdXLpKnf9eypV
 6wBrO7xfqYErJwuaWVWvrmqXNO044XgBQQbfUD9ND/YMHlbqnAD0pghr8CX+JY06+lt5noX7NZW
 Xyr/5jydid0pp3iEbi8yhev2f6yT/SlCJv+3/XtEbb17zhph05Js+
X-Received: by 2002:a25:d008:0:b0:dc2:3d03:bce8 with SMTP id
 h8-20020a25d008000000b00dc23d03bce8mr1703376ybg.127.1705913678880; 
 Mon, 22 Jan 2024 00:54:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI7o5v7Tmsy+SN96LbAhXxEXUefxbbknNkRvJoiGG6IjwJj7nBOLf2ae/VhRzn6/MPQ04pmg==
X-Received: by 2002:a25:d008:0:b0:dc2:3d03:bce8 with SMTP id
 h8-20020a25d008000000b00dc23d03bce8mr1703372ybg.127.1705913678633; 
 Mon, 22 Jan 2024 00:54:38 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 oj12-20020a056214440c00b0068692cf249fsm567333qvb.122.2024.01.22.00.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 00:54:38 -0800 (PST)
Message-ID: <20754e51-3100-4eab-a04d-110ca229a38b@redhat.com>
Date: Mon, 22 Jan 2024 09:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How can I know Page Table address on RAM?
To: Junho <junho920219@gmail.com>, qemu-ppc@nongnu.org
References: <CACrrvNSKQ1du+f40RvcDCvhjojvvDSsHi0FyWoJMMBtt8R+Q3A@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CACrrvNSKQ1du+f40RvcDCvhjojvvDSsHi0FyWoJMMBtt8R+Q3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 22/01/2024 05.11, Junho wrote:
> Hello,
> 
> I'm a QEMU user with PowerPc target architecture.
> I have some personal modifications related to tb jmp cache and chaining 
> logic to improve the performance of a specific guest code. To verify the 
> safety, I have to guarantee that the page table on RAM does not change after 
> initialization. Do you have any information related to this work? Currently, 
> what I need to find is the page table start address on the RAM so that I can 
> test with the range detected.
> 
> I look forward to your response.
> 
> Thank you
> Junho

  Hi,

maybe it's best to ask this question on the qemu-ppc mailing list instead 
(done now), since most PPC folks will rather read than one instead of the 
high-traffic qemu-devel mailing list.

  HTH,
   Thomas


