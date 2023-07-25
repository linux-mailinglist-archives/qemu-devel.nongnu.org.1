Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E17623E2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOOwf-0003O1-Mk; Tue, 25 Jul 2023 16:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qOOwd-0003NE-Qh
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:47:47 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qOOwb-0005Oh-2M
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:47:47 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5634db21a58so4114242eaf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690318063; x=1690922863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wixLGoQRiqHjcCQTbqhT2wR8iYcO6mxZ8IUZ6g40OJA=;
 b=AHfDJj59GjZOCJ3sXkhKRZecEc6xquNhhimgGYI2DIivxNTImcwv0JkUz9EzeoCjdP
 HJIfEbLTL0WQqzRIFzj5DfICRJ2Jmv5YzA9wGWou5/EOZ3FHaWuSUEdpHlS2oBt+RsjH
 GZoYTCUg5+XIouEyNLIAhdNJmhcvjr8T1fJumf7L9JO+MELlynSNY+0wsNzcJRqoqDJA
 PuO14iRG3WcFZYEjjkL/vLf6nVKt++lvfTCot7rsCRWx/j2qTrEgr9V/8KgpBfmAi/4a
 G0LNS6GuxYGo2Q6sK6D5Tm5E77SGJIbBFd8T4KeI45322KKV2UBhRKErQnArnw/cDnGf
 AoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690318063; x=1690922863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wixLGoQRiqHjcCQTbqhT2wR8iYcO6mxZ8IUZ6g40OJA=;
 b=CMH5jpHc71DcPaamGQvPvYccPstNuYokATbl8vJrcnUAMAvdby805FiyIvWv0wEU3g
 rpgWR9ekYtYUG+Z6dA8zCYojxVlFz/HR1s6qvufmbQ6vPkhbD8bzkb6CWTPZFKiMr/FB
 isN5Fw0PPntjg5A8iYwpuf5Hd1HxlCo2Fv0zb49fjQzTqhBusyhtj0/3+mOJXuUDVoEA
 XaDzMuEz3TdVD5BpyGVMNAXD2kaY00R/qUavGxZLmWRH2D3fAlMV8An8wlOBbDj38D3c
 LauhhzuNkZrsK2w4XCqH3xSONcwkWtQTjkQoWyvnOGMNK0pc2PrzRcXBO6oKjVUVG+P5
 fQhQ==
X-Gm-Message-State: ABy/qLZ7rxjLWhHl5Yp9AL4ql7xpnji/y7lf2/RwiKOsK0mFeHJbJrfA
 Wt6C7V02hHYCgW119wnA23guta3ZPwyME+DVB7Q=
X-Google-Smtp-Source: APBJJlHkzHiJ0NclKrDIN+a3BLaBv/6p4Mm8aNhPHFufDz6udSwbw3B3HYIxzu9Qv/OOfRGmNQ/WofQ5zjO1v2xSbaU=
X-Received: by 2002:a4a:8299:0:b0:565:cf26:5a10 with SMTP id
 e25-20020a4a8299000000b00565cf265a10mr26525oog.0.1690318062718; Tue, 25 Jul
 2023 13:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230718094150.110183-1-william.henderson@nutanix.com>
In-Reply-To: <20230718094150.110183-1-william.henderson@nutanix.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 25 Jul 2023 16:47:30 -0400
Message-ID: <CAJSP0QVJZMuuPqyt3wA=NRLzKB-TLWjGWuYnfRvUd=LXraZUWg@mail.gmail.com>
Subject: Re: [RFC PATCH] vfio-user: add live migration to vfio-user protocol
 specification
To: William Henderson <william.henderson@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 John Levon <john.levon@nutanix.com>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "clg@redhat.com" <clg@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Jul 2023 at 05:42, William Henderson
<william.henderson@nutanix.com> wrote:
>
> This patch adds live migration to the vfio-user specification, based on the new
> VFIO migration interface introduced in the kernel here:
>
> https://lore.kernel.org/all/20220224142024.147653-10-yishaih@nvidia.com/

Hi,
This is not an in-depth review, but here is what I have:

>
> We differ from the VFIO protocol in that, while VFIO transfers migration data
> using a file descriptor, we simply use the already-established vfio-user socket
> with two additional commands, VFIO_USER_MIG_DATA_READ and
> VFIO_USER_MIG_DATA_WRITE, which have stream semantics.

Transferring migration data over a separate fd eliminates the risk of
blocking the vfio-user socket and might make zero-copy easier. Are you
sure you want to transfer migration data over the vfio-user socket?

> We also don't use P2P
> states as we don't yet have a use-case for them, although this may change in the
> future.
>
> This patch should be applied on the previous pending patch which introduces
> the vfio-user protocol:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06567.html
> Signed-off-by: William Henderson <william.henderson@nutanix.com>
> ---
>  docs/devel/vfio-user.rst | 413 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 396 insertions(+), 17 deletions(-)
>
> diff --git a/docs/devel/vfio-user.rst b/docs/devel/vfio-user.rst
> index 0d96477a68..f433579db0 100644
> --- a/docs/devel/vfio-user.rst
> +++ b/docs/devel/vfio-user.rst
> @@ -4,7 +4,7 @@ vfio-user Protocol Specification
>  ********************************
>
>  --------------
> -Version_ 0.9.1
> +Version_ 0.9.2
>  --------------
>
>  .. contents:: Table of Contents
> @@ -366,6 +366,9 @@ Name                                    Command    Request Direction
>  ``VFIO_USER_DMA_WRITE``                 12         server -> client
>  ``VFIO_USER_DEVICE_RESET``              13         client -> server
>  ``VFIO_USER_REGION_WRITE_MULTI``        15         client -> server
> +``VFIO_USER_DEVICE_FEATURE``            16         client -> server
> +``VFIO_USER_MIG_DATA_READ``             17         client -> server
> +``VFIO_USER_MIG_DATA_WRITE``            18         client -> server
>  ======================================  =========  =================
>
>  Header
> @@ -508,26 +511,10 @@ Capabilities:
>  |                    |         | valid simultaneously.  Optional, with a        |
>  |                    |         | value of 65535 (64k-1).                        |
>  +--------------------+---------+------------------------------------------------+
> -| migration          | object  | Migration capability parameters. If missing    |
> -|                    |         | then migration is not supported by the sender. |
> -+--------------------+---------+------------------------------------------------+
>  | write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages      |
>  |                    |         | are supported if the value is ``true``.        |
>  +--------------------+---------+------------------------------------------------+
>
> -The migration capability contains the following name/value pairs:
> -
> -+-----------------+--------+--------------------------------------------------+
> -| Name            | Type   | Description                                      |
> -+=================+========+==================================================+
> -| pgsize          | number | Page size of dirty pages bitmap. The smallest    |
> -|                 |        | between the client and the server is used.       |
> -+-----------------+--------+--------------------------------------------------+
> -| max_bitmap_size | number | Maximum bitmap size in ``VFIO_USER_DIRTY_PAGES`` |
> -|                 |        | and ``VFIO_DMA_UNMAP`` messages.  Optional,      |
> -|                 |        | with a default value of 256MB.                   |
> -+-----------------+--------+--------------------------------------------------+
> -

Why are existing spec features being deleted? Are you sure there are
no existing implementations of the old migration interface and there
is no need to keep the spec backwards compatible?

>  Reply
>  ^^^^^
>
> @@ -1468,6 +1455,398 @@ Reply
>
>  * *wr_cnt* is the number of device writes completed.
>
> +``VFIO_USER_DEVICE_FEATURE``
> +----------------------------
> +
> +This command is analogous to ``VFIO_DEVICE_FEATURE``. It is used to get, set, or
> +probe feature data of the device.
> +
> +Request
> +^^^^^^^
> +
> +The request payload for this message is a structure of the following format.
> +
> ++-------+--------+--------------------------------+
> +| Name  | Offset | Size                           |
> ++=======+========+================================+
> +| argsz | 0      | 4                              |
> ++-------+--------+--------------------------------+
> +| flags | 4      | 4                              |
> ++-------+--------+--------------------------------+
> +|       | +---------+---------------------------+ |
> +|       | | Bit     | Definition                | |
> +|       | +=========+===========================+ |
> +|       | | 0 to 15 | Feature bits              | |

This is a "feature index" according to <linux/vfio.h>. Please use that
term for consistency and to make it clear that this is a number (e.g.
0-65535) and not a bitmap of 16 features.

> +|       | +---------+---------------------------+ |
> +|       | | 16      | VFIO_DEVICE_FEATURE_GET   | |
> +|       | +---------+---------------------------+ |
> +|       | | 17      | VFIO_DEVICE_FEATURE_SET   | |
> +|       | +---------+---------------------------+ |
> +|       | | 18      | VFIO_DEVICE_FEATURE_PROBE | |
> +|       | +---------+---------------------------+ |
> ++-------+--------+--------------------------------+
> +| data  | 8      | variable                       |
> ++-------+--------+--------------------------------+
> +
> +* *argsz* is the size of the above structure.
> +
> +* *flags* defines the action to be performed by the server and upon which
> +  feature:
> +
> +  * The feature bits are the least significant 16 bits of the flags field, and

"feature bits are" -> "feature index consists of"

> +    can be accessed using the ``VFIO_DEVICE_FEATURE_MASK`` bit mask.
> +
> +  * ``VFIO_DEVICE_FEATURE_GET`` instructs the server to get the data for the
> +    given feature.
> +
> +  * ``VFIO_DEVICE_FEATURE_SET`` instructs the server to set the feature data to
> +    that given in the ``data`` field of the payload.
> +
> +  * ``VFIO_DEVICE_FEATURE_PROBE`` instructs the server to probe for feature
> +    support. If ``VFIO_DEVICE_FEATURE_GET`` and/or ``VFIO_DEVICE_FEATURE_SET``
> +    are also set, the probe will only return success if all of the indicated
> +    methods are supported.
> +
> +  ``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually
> +  exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.
> +
> +* *data* is specific to the particular feature. It is not used for probing.
> +
> +This part of the request is analogous to VFIO's ``struct vfio_device_feature``.
> +
> +Reply
> +^^^^^
> +
> +The reply payload must be the same as the request payload for setting or
> +probing a feature. For getting a feature's data, the data is added in the data
> +section and its length is added to ``argsz``.
> +
> +Device Features
> +^^^^^^^^^^^^^^^
> +
> +The only device features supported by vfio-user are those related to migration,
> +although this may change in the future. They are a subset of those supported in
> +the VFIO implementation of the Linux kernel.
> +
> ++----------------------------------------+-------+
> +| Name                                   | Value |

"Value" -> "Feature Index" would be clearer. The reader currently has
to figure that out for themselves.

> ++========================================+=======+
> +| VFIO_DEVICE_FEATURE_MIGRATION          | 1     |
> ++----------------------------------------+-------+
> +| VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE   | 2     |
> ++----------------------------------------+-------+
> +| VFIO_DEVICE_FEATURE_DMA_LOGGING_START  | 6     |
> ++----------------------------------------+-------+
> +| VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP   | 7     |
> ++----------------------------------------+-------+
> +| VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT | 8     |
> ++----------------------------------------+-------+
> +
> +``VFIO_DEVICE_FEATURE_MIGRATION``
> +"""""""""""""""""""""""""""""""""
> +
> +This feature indicates that the device can support the migration API through
> +``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``. If ``GET`` succeeds, the ``RUNNING``
> +and ``ERROR`` states are always supported. Support for additional states is
> +indicated via the flags field; at least ``VFIO_MIGRATION_STOP_COPY`` must be
> +set.
> +
> +There is no data field of the request message.
> +
> +The data field of the reply message is structured as follows:
> +
> ++-------+--------+---------------------------+
> +| Name  | Offset | Size                      |
> ++=======+========+===========================+
> +| flags | 0      | 8                         |
> ++-------+--------+---------------------------+
> +|       | +-----+--------------------------+ |
> +|       | | Bit | Definition               | |
> +|       | +=====+==========================+ |
> +|       | | 0   | VFIO_MIGRATION_STOP_COPY | |
> +|       | +-----+--------------------------+ |
> +|       | | 1   | VFIO_MIGRATION_P2P       | |
> +|       | +-----+--------------------------+ |
> +|       | | 2   | VFIO_MIGRATION_PRE_COPY  | |
> +|       | +-----+--------------------------+ |
> ++-------+--------+---------------------------+
> +
> +These flags are interpreted in the same way as VFIO.
> +
> +``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``
> +""""""""""""""""""""""""""""""""""""""""
> +
> +Upon ``VFIO_DEVICE_FEATURE_SET``, execute a migration state change on the VFIO
> +device. The new state is supplied in ``device_state``. The state transition must
> +fully complete before the reply is sent.
> +
> +The data field of the reply message, as well as the ``SET`` request message, is
> +structured as follows:
> +
> ++--------------+--------+------+
> +| Name         | Offset | Size |
> ++==============+========+======+
> +| device_state | 0      | 4    |
> ++--------------+--------+------+
> +| data_fd      | 4      | 4    |
> ++--------------+--------+------+
> +
> +* *device_state* is the current state of the device (for ``GET``) or the
> +  state to transition to (for ``SET``). It is defined by the
> +  ``vfio_device_mig_state`` enum as detailed below. These states are the states
> +  of the device migration Finite State Machine.
> +
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| Name                           | State | Description                                                         |
> ++================================+=======+=====================================================================+
> +| VFIO_DEVICE_STATE_ERROR        | 0     | The device has failed and must be reset.                            |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_STOP         | 1     | The device does not change the internal or external state.          |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_RUNNING      | 2     | The device is running normally.                                     |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_STOP_COPY    | 3     | The device internal state can be read out.                          |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_RESUMING     | 4     | The device is stopped and is loading a new internal state.          |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_RUNNING_P2P  | 5     | (not used in vfio-user)                                             |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_PRE_COPY     | 6     | The device is running normally but tracking internal state changes. |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +| VFIO_DEVICE_STATE_PRE_COPY_P2P | 7     | (not used in vfio-user)                                             |
> ++--------------------------------+-------+---------------------------------------------------------------------+
> +
> +* *data_fd* is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and
> +  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration data
> +  transport.
> +
> +Direct State Transitions
> +""""""""""""""""""""""""
> +
> +The device migration FSM is a Mealy machine, so actions are taken upon the arcs
> +between FSM states. The following transitions need to be supported by the
> +server, a subset of those defined in ``<linux/vfio.h>``
> +(``enum vfio_device_mig_state``).
> +
> +* ``RUNNING -> STOP``, ``STOP_COPY -> STOP``: Stop the operation of the device.
> +  The ``STOP_COPY`` arc terminates the data transfer session.
> +
> +* ``RESUMING -> STOP``: Terminate the data transfer session. Complete processing
> +  of the migration data. Stop the operation of the device. If the delivered data
> +  is found to be incomplete, inconsistent, or otherwise invalid, fail the
> +  ``SET`` command and optionally transition to the ``ERROR`` state.
> +
> +* ``PRE_COPY -> RUNNING``: Terminate the data transfer session. The device is
> +  now fully operational.
> +
> +* ``STOP -> RUNNING``: Start the operation of the device.
> +
> +* ``RUNNING -> PRE_COPY``, ``STOP -> STOP_COPY``: Begin the process of saving
> +  the device state. The device operation is unchanged, but data transfer begins.
> +  ``PRE_COPY`` and ``STOP_COPY`` are referred to as the "saving group" of
> +  states.
> +
> +* ``PRE_COPY -> STOP_COPY``: Continue to transfer migration data, but stop
> +  device operation.
> +
> +* ``STOP -> RESUMING``: Start the process of restoring the device state. The
> +  internal device state may be changed to prepare the device to receive the
> +  migration data.
> +
> +The ``STOP_COPY -> PRE_COPY`` transition is explicitly not allowed and should
> +return an error if requested.
> +
> +``ERROR`` cannot be specified as a device state, but any transition request can
> +be failed and then move the state into ``ERROR`` if the server was unable to
> +execute the requested arc AND was unable to restore the device into any valid
> +state. To recover from ``ERROR``, ``VFIO_USER_DEVICE_RESET`` must be used to
> +return back to ``RUNNING``.
> +
> +If ``PRE_COPY`` is not supported, arcs touching it are removed.
> +
> +Complex State Transitions
> +"""""""""""""""""""""""""
> +
> +The remaining possible transitions are to be implemented as combinations of the
> +above FSM arcs. As there are multiple paths, the path should be selected based
> +on the following rules:
> +
> +* Select the shortest path.
> +
> +* The path cannot have saving group states as interior arcs, only start/end
> +  states.
> +
> +``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` / ``VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP``
> +""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +
> +Upon ``VFIO_DEVICE_FEATURE_SET``, start/stop DMA logging. These features can
> +also be probed to determine whether the device supports DMA logging.
> +
> +When DMA logging is started, a range of IOVAs to monitor is provided and the
> +device can optimize its logging to cover only the IOVA range given. Only DMA
> +writes are logged.
> +
> +The data field of the ``SET`` request is structured as follows:
> +
> ++------------+--------+----------+
> +| Name       | Offset | Size     |
> ++============+========+==========+
> +| page_size  | 0      | 8        |
> ++------------+--------+----------+
> +| num_ranges | 8      | 4        |
> ++------------+--------+----------+
> +| reserved   | 12     | 4        |
> ++------------+--------+----------+
> +| ranges     | 16     | variable |
> ++------------+--------+----------+
> +
> +* *page_size* hints what tracking granularity the device should try to achieve.
> +  If the device cannot do the hinted page size then it's the driver's choice
> +  which page size to pick based on its support. On output the device will return
> +  the page size it selected.
> +
> +* *num_ranges* is the number of IOVA ranges to monitor. A value of zero
> +  indicates that all writes should be logged.
> +
> +* *ranges* is an array of ``vfio_user_device_feature_dma_logging_range``
> +  entries:
> +
> ++--------+--------+------+
> +| Name   | Offset | Size |
> ++========+========+======+
> +| iova   | 0      | 8    |
> ++--------+--------+------+
> +| length | 8      | 8    |
> ++--------+--------+------+
> +
> +  * *iova* is the base IO virtual address
> +  * *length* is the length of the range to log
> +
> +Upon success, the response data field will be the same as the request, unless
> +the page size was changed, in which case this will be reflected in the response.
> +
> +``VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT``
> +""""""""""""""""""""""""""""""""""""""""""
> +
> +Upon ``VFIO_DEVICE_FEATURE_GET``, returns the dirty bitmap for a specific IOVA
> +range. This operation is only valid if logging of dirty pages has been
> +previously started by setting ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START``.
> +
> +The data field of the request is structured as follows:
> +
> ++-----------+--------+------+
> +| Name      | Offset | Size |
> ++===========+========+======+
> +| iova      | 0      | 8    |
> ++-----------+--------+------+
> +| length    | 8      | 8    |
> ++-----------+--------+------+
> +| page_size | 16     | 8    |
> ++-----------+--------+------+
> +
> +* *iova* is the base IO virtual address
> +
> +* *length* is the length of the range
> +
> +* *page_size* is the unit of granularity of the bitmap, and must be a power of
> +  two. It doesn't have to match the value given to
> +  ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` because the driver will format its
> +  internal logging to match the reporting page size possibly by replicating bits
> +  if the internal page size is lower than requested
> +
> +The data field of the response is identical, except with the bitmap added on
> +the end at offset 24.
> +
> +The mapping of IOVA to bits is given by:
> +
> +``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``
> +
> +``VFIO_USER_MIG_DATA_READ``
> +---------------------------
> +
> +This command is used to read data from the source migration server while it is
> +in a saving group state (``PRE_COPY`` or ``STOP_COPY``).
> +
> +This command, and ``VFIO_USER_MIG_DATA_WRITE``, are used in place of the
> +``data_fd`` file descriptor in ``<linux/vfio.h>``
> +(``struct vfio_device_feature_mig_state``) to enable all data transport to use
> +the single already-established UNIX socket. Hence, the migration data is
> +treated like a stream, so the client must continue reading until no more
> +migration data remains.
> +
> +Request
> +^^^^^^^
> +
> +The request payload for this message is a structure of the following format.
> +
> ++-------+--------+------+
> +| Name  | Offset | Size |
> ++=======+========+======+
> +| argsz | 0      | 4    |
> ++-------+--------+------+
> +| size  | 4      | 4    |
> ++-------+--------+------+
> +
> +* *argsz* is the size of the above structure.
> +
> +* *size* is the size of the migration data to read.
> +
> +Reply
> +^^^^^
> +
> +The reply payload for this message is a structure of the following format.
> +
> ++-------+--------+----------+
> +| Name  | Offset | Size     |
> ++=======+========+==========+
> +| argsz | 0      | 4        |
> ++-------+--------+----------+
> +| size  | 4      | 4        |
> ++-------+--------+----------+
> +| data  | 8      | variable |
> ++-------+--------+----------+
> +
> +* *argsz* is the size of the above structure.
> +
> +* *size* indicates the size of returned migration data. If this is less than the
> +  requested size, there is no more migration data to read.

Does reply.size need to be equal to request.size in order for the
client to continue reading migration data? If yes, then the vfio-user
socket is blocked from further request processing until the server has
the requested number of bytes. No other vfio-user requests can be sent
during that time. It might be trivial for the server to immediately
reply with the requested number of bytes of migration data in most
implementations. However, some implementations may not be able to
reply immediately and I'm worried that this design leaves the
vhost-user socket blocked. This is a scenario where a separate fd
helps.

Is there a way for the server to indicate an error to the client? It
seems like the server can only end the data transfer early, but the
client won't know that the data should be discarded because an error
has occurred.

> +
> +* *data* contains the migration data.
> +
> +``VFIO_USER_MIG_DATA_WRITE``
> +----------------------------
> +
> +This command is used to write data to the destination migration server while it
> +is in the ``RESUMING`` state.
> +
> +As above, this replaces the ``data_fd`` file descriptor for transport of
> +migration data, and as such, the migration data is treated like a stream.
> +
> +Request
> +^^^^^^^
> +
> +The request payload for this message is a structure of the following format.
> +
> ++-------+--------+----------+
> +| Name  | Offset | Size     |
> ++=======+========+==========+
> +| argsz | 0      | 4        |
> ++-------+--------+----------+
> +| size  | 4      | 4        |
> ++-------+--------+----------+
> +| data  | 8      | variable |
> ++-------+--------+----------+
> +
> +* *argsz* is the size of the above structure.
> +
> +* *size* is the size of the migration data to be written.
> +
> +* *data* contains the migration data.
> +
> +Reply
> +^^^^^
> +
> +There is no reply payload for this message.
>
>  Appendices
>  ==========
> --
> 2.22.3
>

